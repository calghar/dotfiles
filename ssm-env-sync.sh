#!/bin/bash

# 🔐 SSM Env Sync
# Pulls selected secrets from AWS SSM Parameter Store into a shell env file.
#
# Only the variables named in the manifest are managed. Existing exports of those
# names are replaced in place; every other line in the target file is preserved,
# so hand-written entries can sit alongside the synced ones.
#
# Values are never printed, logged, or passed on a command line — only variable
# names, value lengths, and status.

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_step() { echo -e "${BLUE}▶${NC} $1"; }
print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }

DEFAULT_MANIFEST="${SSM_ENV_MANIFEST:-$HOME/.config/ssm-env/manifest}"
DEFAULT_TARGET="$HOME/.zshrc.local"
# Values that mean "this parameter was never filled in" — refuse to sync them.
PLACEHOLDER_VALUES="PLACEHOLDER CHANGEME TODO none null"

MANIFEST="$DEFAULT_MANIFEST"
TARGET="$DEFAULT_TARGET"
MODE="sync"

usage() {
    cat <<EOF
Usage: ssm-env-sync.sh [options]

Sync the environment variables named in a manifest from AWS SSM Parameter Store
into a shell env file, leaving every unlisted line untouched.

Options:
  -m, --manifest FILE  Manifest to read (default: \$SSM_ENV_MANIFEST, else
                       ~/.config/ssm-env/manifest)
  -f, --file FILE      Env file to write (default: ~/.zshrc.local)
  -c, --check          Report drift between the env file and SSM; write nothing.
                       Exits 1 if any managed variable is missing or stale.
  -l, --list           Print the managed variables and their parameters, then exit
  -h, --help           Show this help

Manifest format — one entry per line, see ssm-env.manifest.example:
  ENV_VAR   SSM_PARAMETER_PATH   REGION

Requires the AWS CLI with credentials that can ssm:GetParameter (with decryption)
on every listed parameter.
EOF
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -m|--manifest) MANIFEST="$2"; shift 2 ;;
        -f|--file) TARGET="$2"; shift 2 ;;
        -c|--check) MODE="check"; shift ;;
        -l|--list) MODE="list"; shift ;;
        -h|--help) usage; exit 0 ;;
        *) print_error "Unknown option: $1"; usage; exit 2 ;;
    esac
done

if ! command -v aws >/dev/null 2>&1; then
    print_error "aws CLI not found. Install it with: brew install awscli"
    exit 1
fi

if [[ ! -f "$MANIFEST" ]]; then
    print_error "Manifest not found: $MANIFEST"
    echo "  Copy ssm-env.manifest.example to $DEFAULT_MANIFEST and edit it."
    exit 1
fi

# Parse the manifest into three parallel arrays (bash 3.2 has no associative arrays).
VAR_NAMES=(); VAR_PARAMS=(); VAR_REGIONS=()
line_no=0
while IFS= read -r line || [[ -n "$line" ]]; do
    line_no=$((line_no + 1))
    line="${line%%#*}"
    [[ -z "${line// /}" ]] && continue
    read -r name param region _rest <<<"$line"
    if [[ -z "$name" || -z "$param" || -z "$region" ]]; then
        print_error "$MANIFEST:$line_no — expected: ENV_VAR SSM_PARAMETER_PATH REGION"
        exit 2
    fi
    if [[ ! "$name" =~ ^[A-Za-z_][A-Za-z_0-9]*$ ]]; then
        print_error "$MANIFEST:$line_no — '$name' is not a valid shell variable name"
        exit 2
    fi
    VAR_NAMES+=("$name"); VAR_PARAMS+=("$param"); VAR_REGIONS+=("$region")
done <"$MANIFEST"

if [[ ${#VAR_NAMES[@]} -eq 0 ]]; then
    print_error "No entries in $MANIFEST"
    exit 2
fi

if [[ "$MODE" == "list" ]]; then
    print_step "Managed by $MANIFEST:"
    for i in "${!VAR_NAMES[@]}"; do
        printf '  %-28s %s (%s)\n' "${VAR_NAMES[$i]}" "${VAR_PARAMS[$i]}" "${VAR_REGIONS[$i]}"
    done
    exit 0
fi

# Wrap a value in single quotes, escaping any single quotes inside it.
shell_quote() { printf "'%s'" "${1//\'/\'\\\'\'}"; }

# Read what a variable is currently set to in an env file. Compares values rather
# than whole lines, so an entry written by hand — quoted differently, or not at all
# — is not mistaken for drift. Returns 1 when the variable is absent.
current_value() {
    local name="$1" file="$2" rhs
    [[ -f "$file" ]] || return 1
    rhs=$(grep -E "^[[:space:]]*export[[:space:]]+${name}=" "$file" | tail -1) || return 1
    [[ -n "$rhs" ]] || return 1
    eval "printf '%s' ${rhs#*=}" 2>/dev/null || return 1
}

print_step "Fetching ${#VAR_NAMES[@]} parameter(s) from SSM"

VALUES=()
for i in "${!VAR_NAMES[@]}"; do
    name="${VAR_NAMES[$i]}"
    if ! value=$(aws ssm get-parameter \
        --region "${VAR_REGIONS[$i]}" \
        --name "${VAR_PARAMS[$i]}" \
        --with-decryption \
        --query 'Parameter.Value' \
        --output text 2>/dev/null); then
        print_error "$name — cannot read ${VAR_PARAMS[$i]} in ${VAR_REGIONS[$i]}"
        exit 1
    fi
    if [[ -z "$value" || "$value" == "None" ]]; then
        print_error "$name — parameter is empty"
        exit 1
    fi
    for placeholder in $PLACEHOLDER_VALUES; do
        if [[ "$value" == "$placeholder" ]]; then
            print_error "$name — parameter still holds the placeholder '$placeholder'. Set a real value in SSM first."
            exit 1
        fi
    done
    VALUES+=("$value")
    print_success "$name (${#value} chars)"
done

if [[ "$MODE" == "check" ]]; then
    drift=0
    for i in "${!VAR_NAMES[@]}"; do
        name="${VAR_NAMES[$i]}"
        if ! have=$(current_value "$name" "$TARGET"); then
            print_warning "$name is missing from $TARGET"
            drift=1
        elif [[ "$have" != "${VALUES[$i]}" ]]; then
            print_warning "$name in $TARGET does not match SSM"
            drift=1
        fi
    done
    if [[ $drift -eq 0 ]]; then
        print_success "$TARGET matches SSM"
        exit 0
    fi
    print_error "Drift found. Run without --check to sync."
    exit 1
fi

# Write through a 0600 temp file in the target's directory, then rename, so the
# secrets are never briefly world-readable and a crash cannot truncate the target.
target_dir=$(dirname "$TARGET")
mkdir -p "$target_dir"
[[ -f "$TARGET" ]] || : >"$TARGET"

tmp=$(mktemp "$target_dir/.ssm-env-sync.XXXXXX")
chmod 600 "$tmp"
trap 'rm -f "$tmp"' EXIT

replaced=""
while IFS= read -r line || [[ -n "$line" ]]; do
    out="$line"
    for i in "${!VAR_NAMES[@]}"; do
        name="${VAR_NAMES[$i]}"
        if [[ "$line" =~ ^[[:space:]]*export[[:space:]]+${name}= ]]; then
            out="export $name=$(shell_quote "${VALUES[$i]}")"
            replaced="$replaced $name"
            break
        fi
    done
    printf '%s\n' "$out" >>"$tmp"
done <"$TARGET"

appended=""
for i in "${!VAR_NAMES[@]}"; do
    name="${VAR_NAMES[$i]}"
    [[ " $replaced " == *" $name "* ]] && continue
    appended="$appended $name"
done

if [[ -n "$appended" ]]; then
    printf '\n# Synced from AWS SSM by ssm-env-sync.sh — do not edit by hand\n' >>"$tmp"
    for i in "${!VAR_NAMES[@]}"; do
        name="${VAR_NAMES[$i]}"
        [[ " $appended " == *" $name "* ]] || continue
        printf 'export %s=%s\n' "$name" "$(shell_quote "${VALUES[$i]}")" >>"$tmp"
    done
fi

mv "$tmp" "$TARGET"
trap - EXIT
chmod 600 "$TARGET"

[[ -n "$replaced" ]] && print_success "Updated:$replaced"
[[ -n "$appended" ]] && print_success "Added:$appended"
print_success "Wrote $TARGET (mode 600)"
print_warning "Open a new shell to pick up the values. Restart any tool that reads them at launch."
