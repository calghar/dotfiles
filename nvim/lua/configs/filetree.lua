local M = {}

M.nvimtree = {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	lazy = false,
	cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFindFile" },
	keys = {
		{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
		{ "<C-n>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
		{ "<leader>ef", "<cmd>NvimTreeFindFile<cr>", desc = "Find file in tree" },
	},
	config = function()
		require("nvim-tree").setup({
			-- Disable netrw
			disable_netrw = true,
			hijack_netrw = true,
			
			-- Open tree on startup
			hijack_directories = {
				enable = true,
				auto_open = true,
			},
			
			-- Update focused file
			update_focused_file = {
				enable = true,
				update_cwd = false,
				ignore_list = {},
			},
			
			-- View settings
			view = {
				side = "left",
				width = 35,
				preserve_window_proportions = true,
				number = false,
				relativenumber = false,
				signcolumn = "yes",
			},
			
			-- Renderer settings
			renderer = {
				root_folder_label = ":~:s?$?/..?",
				highlight_git = true,
				highlight_opened_files = "name",
				indent_width = 2,
				indent_markers = {
					enable = true,
					inline_arrows = true,
					icons = {
						corner = "└",
						edge = "│",
						item = "│",
						bottom = "─",
						none = " ",
					},
				},
				icons = {
					webdev_colors = true,
					git_placement = "before",
					modified_placement = "after",
					padding = " ",
					symlink_arrow = " ➛ ",
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
						modified = true,
					},
					glyphs = {
						default = "󰈚",
						symlink = "",
						bookmark = "",
						modified = "●",
						folder = {
							arrow_closed = "",
							arrow_open = "",
							default = "",
							open = "",
							empty = "",
							empty_open = "",
							symlink = "",
							symlink_open = "",
						},
						git = {
							unstaged = "✗",
							staged = "✓",
							unmerged = "",
							renamed = "➜",
							untracked = "★",
							deleted = "",
							ignored = "◌",
						},
					},
				},
			},
			
			-- Actions
			actions = {
				use_system_clipboard = true,
				change_dir = {
					enable = true,
					global = false,
					restrict_above_cwd = false,
				},
				expand_all = {
					max_folder_discovery = 300,
					exclude = {},
				},
				file_popup = {
					open_win_config = {
						col = 1,
						row = 1,
						relative = "cursor",
						border = "shadow",
						style = "minimal",
					},
				},
				open_file = {
					quit_on_open = false,
					resize_window = true,
					window_picker = {
						enable = true,
						picker = "default",
						chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
						exclude = {
							filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
							buftype = { "nofile", "terminal", "help" },
						},
					},
				},
				remove_file = {
					close_window = true,
				},
			},
			
			-- Git integration
			git = {
				enable = true,
				ignore = true,
				show_on_dirs = true,
				timeout = 400,
			},
			
			-- Diagnostics
			diagnostics = {
				enable = true,
				show_on_dirs = false,
				show_on_open_dirs = true,
				debounce_delay = 50,
				severity = {
					min = vim.diagnostic.severity.HINT,
					max = vim.diagnostic.severity.ERROR,
				},
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
			
			-- Modified files
			modified = {
				enable = true,
				show_on_dirs = true,
				show_on_open_dirs = true,
			},
			
			-- Filters
			filters = {
				dotfiles = false,
				git_clean = false,
				no_buffer = false,
				custom = { "^.git$" },
				exclude = {},
			},
			
			-- Live filter
			live_filter = {
				prefix = "[FILTER]: ",
				always_show_folders = true,
			},
			
			-- Trash
			trash = {
				cmd = "gio trash",
				require_confirm = true,
			},
			
			-- Tab
			tab = {
				sync = {
					open = false,
					close = false,
					ignore = {},
				},
			},
			
			-- Notify
			notify = {
				threshold = vim.log.levels.INFO,
			},
			
			-- Logging
			log = {
				enable = false,
				truncate = false,
				types = {
					all = false,
					config = false,
					copy_paste = false,
					dev = false,
					diagnostics = false,
					git = false,
					profile = false,
					watcher = false,
				},
			},
		})
		
		-- Auto-close nvim-tree if it's the last window
		local function tab_win_closed(winnr)
			local api = require("nvim-tree.api")
			local tabnr = vim.api.nvim_win_get_tabpage(winnr)
			local bufnr = vim.api.nvim_win_get_buf(winnr)
			local buf_info = vim.fn.getbufinfo(bufnr)[1]
			local tab_wins = vim.tbl_filter(function(w)
				return w ~= winnr
			end, vim.api.nvim_tabpage_list_wins(tabnr))
			local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
			if buf_info.name:match(".*NvimTree_%d*$") then
				if not vim.tbl_isempty(tab_bufs) then
					local has_nvim_tree = vim.tbl_filter(function(b)
						return vim.fn.getbufinfo(b)[1].name:match(".*NvimTree_%d*$")
					end, tab_bufs)
					if #has_nvim_tree == 0 then
						api.tree.close()
					end
				end
			end
		end
		
		vim.api.nvim_create_autocmd("WinClosed", {
			callback = function()
				local winnr = tonumber(vim.fn.expand("<amatch>"))
				vim.schedule_wrap(tab_win_closed(winnr))
			end,
			nested = true,
		})

		-- Auto-open on startup (VSCode-like)
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function(data)
				local is_dir = vim.fn.isdirectory(data.file) == 1
				if is_dir then
					-- Directory arg: cd in and let nvim-tree hijack the buffer
					vim.cmd.cd(data.file)
					require("nvim-tree.api").tree.open()
				else
					-- File arg or no args: show tree on the side, keep focus on the file/dashboard.
					-- The BufWipeout/BufDelete autocmd in autocmds.lua prunes stale ids
					-- from vim.t.bufs so tabufline next/prev stays safe (E5108).
					require("nvim-tree.api").tree.toggle({ focus = false, find_file = true })
				end
			end,
		})
	end,
}

return M