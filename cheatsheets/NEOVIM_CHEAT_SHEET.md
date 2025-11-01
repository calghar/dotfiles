# Neovim Cheat Sheet
> NvChad Configuration Reference

## Quick Start

| Command | Description |
|---------|-------------|
| `nvim` | Start Neovim |
| `nvim <file>` | Open specific file |
| `nvim .` | Open current directory |

## Leader Key
**Leader:** `<Space>`

---

## Essential Key Bindings

### Basic Operations

| Key | Mode | Action |
|-----|------|--------|
| `;` | Normal | Enter command mode |
| `jk` | Insert | Exit to normal mode |
| `Ctrl+s` | All | Save file |
| `Ctrl+c` | All | Copy to system clipboard |
| `Ctrl+v` | All | Paste from system clipboard |

### Navigation

| Key | Action |
|-----|--------|
| `h/j/k/l` | Move left/down/up/right |
| `w/b` | Next/previous word |
| `0/$` | Start/end of line |
| `gg/G` | Start/end of file |
| `Ctrl+u/d` | Half page up/down |
| `{/}` | Previous/next paragraph |

---

## File Operations

### File Management

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle nvim-tree file explorer |
| `<Ctrl+n>` | Toggle nvim-tree file explorer |
| `<leader>ef` | Find current file in tree |
| `<leader>ff` | Find files |
| `<leader>fa` | Find all files |
| `<leader>fw` | Find word |
| `<leader>fb` | Find buffers |
| `<leader>fh` | Find help |
| `<leader>fo` | Find old files |
| `<leader>fz` | Find in current buffer |

### Custom Telescope

| Key | Action |
|-----|--------|
| `<leader>ft` | Find todo comments |
| `<leader>fs` | Find LSP document symbols |
| `<leader>gm` | Git commits |
| `<leader>ga` | Git status |
| `<leader>cz` | Chezmoi find files |

---

## Buffer Management

| Key | Action |
|-----|--------|
| `<leader>bn` | New buffer |
| `<leader>x` | Close current buffer |
| `<leader>bc` | Close all buffers |
| `<leader>bC` | Close all except current |
| `<leader>bdh` | Close buffers to the left |
| `<leader>bdl` | Close buffers to the right |
| `<leader>bh` | Move buffer left |
| `<leader>bl` | Move buffer right |
| `Tab` | Next buffer |
| `Shift+Tab` | Previous buffer |

---

## Window Management

| Key | Action |
|-----|--------|
| `<leader>v` | Vertical split |
| `<leader>h` | Horizontal split |
| `:vs` or `:vsplit` | Vertical split (command) |
| `:sp` or `:split` | Horizontal split (command) |
| `Ctrl+h/j/k/l` | Navigate windows |
| `Ctrl+w w` | Cycle through windows |
| `Alt+Right` | Increase width |
| `Alt+Left` | Decrease width |
| `Alt+Up` | Increase height |
| `Alt+Down` | Decrease height |

### Tab Management

| Key | Action |
|-----|--------|
| `<leader>tn` | New tab |
| `<leader>tj` | Next tab |
| `<leader>tk` | Previous tab |
| `<leader>tc` | Close tab |

---

## LSP (Language Server)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Go to references |
| `gi` | Go to implementation |
| `K` | Show hover documentation |
| `<leader>sh` | Signature help |
| `<leader>D` | Go to type definition |
| `<leader>ra` | Rename symbol |
| `<leader>ca` | Code actions |
| `<leader>ih` | Toggle inlay hints |

### Diagnostics

| Key | Action |
|-----|--------|
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>q` | Diagnostic quickfix |
| `<leader>e` | Show line diagnostics |

---

## Git Integration

| Key | Action |
|-----|--------|
| `<leader>rh` | Reset hunk |
| `<leader>ph` | Preview hunk |
| `<leader>gb` | Git blame line |
| `<leader>td` | Toggle deleted |
| `<leader>lg` | LazyGit |

---

## Search and Replace

### Flash (Quick Jump)

| Key | Action |
|-----|--------|
| `s` | Flash jump |
| `S` | Flash treesitter |
| `r` | Remote flash (operator pending) |
| `R` | Treesitter search |

### Find and Replace

| Key | Action |
|-----|--------|
| `/` | Search forward |
| `?` | Search backward |
| `n/N` | Next/previous match |
| `*/#` | Search word under cursor |
| `<leader>h` | Clear search highlight |

---

## Code Editing

### Text Objects and Motions

| Key | Action |
|-----|--------|
| `ciw` | Change inner word |
| `caw` | Change around word |
| `ci"` | Change inside quotes |
| `ca"` | Change around quotes |
| `cip` | Change inner paragraph |

### Comments

| Key | Action |
|-----|--------|
| `<leader>/` | Toggle line comment |
| `<leader>A` | Insert comment at end of line |

### Indentation

| Key | Action |
|-----|--------|
| `>>` | Indent line |
| `<<` | Unindent line |
| `=` | Auto-indent |

---

## Plugin Features

### Terminal Integration

#### Floaterm (Legacy)
| Key | Action |
|-----|--------|
| `<leader>if` | Toggle floating terminal |

#### ToggleTerm (Enhanced)
| Key | Action |
|-----|--------|
| `<Ctrl+\>` | Toggle terminal (main) |
| `<leader>th` | Toggle horizontal terminal |
| `<leader>tv` | Toggle vertical terminal |
| `<leader>tt` | Toggle floating terminal |
| `<leader>tb` | Toggle terminal in new tab |

#### Terminal Navigation
| Key | Action |
|-----|--------|
| `<Esc>` or `jk` | Exit terminal mode |
| `<Ctrl+h/j/k/l>` | Navigate between terminal/editor windows |

#### Specialized Terminals
| Key | Action |
|-----|--------|
| `<leader>gg` | Toggle LazyGit |
| `<leader>tn` | Toggle Node.js REPL |
| `<leader>tp` | Toggle Python REPL |
| `<leader>th` | Toggle Htop system monitor |

### Menu System

| Key | Action |
|-----|--------|
| `Ctrl+t` | Open context menu |
| `Right Click` | Context menu (mouse) |

### File Tree Navigation

#### NvimTree (VS Code-like sidebar)
| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file tree explorer |
| `<Ctrl+n>` | Toggle file tree explorer |
| `<leader>ef` | Find current file in tree |

**In NvimTree:**
| Key | Action |
|-----|--------|
| `a` | Add file/folder |
| `r` | Rename file/folder |
| `d` | Delete file/folder |
| `x` | Cut file/folder |
| `c` | Copy file/folder |
| `p` | Paste file/folder |
| `R` | Refresh tree |
| `H` | Toggle hidden files |
| `o` | Open file/folder |
| `<CR>` | Open file/folder |
| `<Tab>` | Open file but keep cursor in tree |
| `v` | Open file in vertical split |
| `s` | Open file in horizontal split |
| `t` | Open file in new tab |
| `<BS>` | Close directory |
| `P` | Go to parent directory |
| `K` | Show file info |
| `<C-k>` | Show file info |
| `y` | Copy filename |
| `Y` | Copy relative path |
| `gy` | Copy absolute path |

#### Yazi File Manager
| Key | Action |
|-----|--------|
| `<leader>-` | Open yazi at current file |
| `<leader>cw` | Open yazi in working directory |
| `Ctrl+Up` | Resume last yazi session |
| `Enter` | Open file in Neovim |
| `q` | Close yazi and return to Neovim |
| `Ctrl+v` | Open file in vertical split |
| `Ctrl+s` | Open file in horizontal split |

**Yazi Workflow:**
- After opening a file from yazi, use `<leader>-` or `Ctrl+Up` to return to file browser
- Use `:q` or `ZZ` to close current file buffer
- `Ctrl+o` may return to previous location (if yazi was last location)

### Color Picker (Minty)

| Key | Action |
|-----|--------|
| `Up Arrow` | Lighten color under cursor |
| `Down Arrow` | Darken color under cursor |

---

## Debugging (DAP)

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Continue |
| `<leader>dr` | Run to cursor |
| `<leader>dR` | Restart |
| `<leader>ds` | Step over |
| `<leader>di` | Step into |
| `<leader>do` | Step out |
| `<leader>dt` | Terminate |

---

## Markdown

| Key | Action |
|-----|--------|
| `<leader>mp` | Markdown preview |

---

## Useful Commands

### File Operations
```vim
:w                  " Save file
:q                  " Quit
:wq                 " Save and quit
:q!                 " Quit without saving
:e <file>           " Edit file
:bd                 " Delete buffer
```

### Search and Replace
```vim
:%s/old/new/g       " Replace all occurrences
:%s/old/new/gc      " Replace with confirmation
:noh                " Clear search highlighting
```

### Window Management
```vim
:sp <file>          " Horizontal split
:vsp <file>         " Vertical split
:res +5             " Resize height
:vertical res +5    " Resize width
```

---

## Tips and Tricks

> **Mode Switching**  
> • `jk` from insert mode is faster than `Esc`  
> • `;` is mapped to `:` for quicker commands

> **Buffer Navigation**  
> • Use `Tab/Shift+Tab` for quick buffer switching  
> • `<leader>fb` for fuzzy buffer search

> **VS Code-like Workflow with NvimTree + Terminal**  
> • `<leader>e` or `Ctrl+n` to toggle sidebar file tree  
> • `<leader>tv` for vertical terminal alongside tree  
> • `<leader>th` for horizontal terminal at bottom  
> • `Ctrl+h/j/k/l` to navigate between tree, editor, and terminal  
> • Files opened from tree appear in main editor area  
> • Tree stays open while you work on multiple files

> **File Tree Workflow (NvimTree)**  
> • Use `<leader>e` to toggle file tree sidebar  
> • Navigate with `j/k`, expand with `o` or `Enter`  
> • `v` opens file in vertical split, `s` in horizontal split  
> • `<leader>ef` finds current file in tree  
> • Tree auto-updates when you switch files  
> • Right-click for context menu

> **Yazi File Manager (Advanced)**  
> • Use `Space -` to open yazi file browser  
> • After opening a file, use `Space -` or `Ctrl+Up` to return to yazi  
> • In yazi: `Ctrl+v` opens files in vertical split  
> • In yazi: `Ctrl+s` opens files in horizontal split  
> • Use `:q` to close current file, `q` to exit yazi

> **Terminal Integration**  
> • `Ctrl+\` for quick floating terminal  
> • `<leader>th` for bottom terminal (great for running tests)  
> • `<leader>tv` for side terminal (VS Code-like)  
> • `<leader>gg` for LazyGit in floating window  
> • `<leader>tp` for Python REPL, `<leader>tn` for Node.js  
> • Use `jk` or `Esc` to exit terminal mode, then `Ctrl+h/j/k/l` to navigate

> **Multi-File Editing**  
> • Open file tree with `<leader>e`  
> • Select files with `v` for vertical split or `s` for horizontal  
> • `Ctrl+w w` cycles through all open windows  
> • `Alt+Left/Right` to resize window widths  
> • Terminal can run alongside your editor splits

> **File Finding**  
> • `<leader>ff` for project files  
> • `<leader>fw` to search for text in files  
> • `<leader>fo` for recently opened files

> **Git Workflow**  
> • `<leader>gg` opens LazyGit in terminal (toggleterm integration)  
> • `<leader>lg` opens LazyGit (snacks integration)  
> • `<leader>gm` for commit history  
> • `<leader>ga` for current status

> **LSP Features**  
> • `K` for quick documentation  
> • `<leader>ca` for available code actions  
> • `<leader>ih` to toggle type hints

> **Development Workflow Example**  
> 1. `<leader>e` - Open file tree sidebar  
> 2. `<leader>th` - Open bottom terminal  
> 3. Navigate in tree, open files with `o` or splits with `v`/`s`  
> 4. Run tests/commands in terminal with `npm test`, `python script.py`, etc.  
> 5. Use `Ctrl+h/j/k/l` to move between tree, editor, and terminal  
> 6. `<leader>gg` for git operations when needed

---

**Built on NvChad with custom enhancements for development productivity**