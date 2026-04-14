local M = {
	flash = {
		"folke/flash.nvim",
		opts = {},
        -- stylua: ignore
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
		config = function()
			dofile(vim.g.base46_cache .. "flash")
			require("flash").setup({
				-- your custom config here (optional)
			})
		end,
	},

	snack = {
		"folke/snacks.nvim",
		-- priority = 1000,
		opts = {
			image = {},
			lazygit = {},
			scroll = {},
		},
		keys = {
      -- stylua: ignore start 
      { "<leader>lg", function() require("snacks").lazygit() end, desc = "LazyGit", },
      {"gg"},
      {"G"},
      { "<c-d>"},
      {"<c-u>" },
			-- stylua: ignore end
		},
	},

	surround = {
		"kylechui/nvim-surround",
		event = "BufRead",
		init = function()
			-- Disable all default keymaps; we set custom ones below
			vim.g.nvim_surround_no_mappings = true
		end,
		config = function()
			require("nvim-surround").setup()
			-- Custom keymaps via <Plug> mappings (see :h nvim-surround.keymaps)
			vim.keymap.set("x", "ss", "<Plug>(nvim-surround-visual)", { desc = "Surround visual selection" })
			vim.keymap.set("x", "sl", "<Plug>(nvim-surround-visual-line)", { desc = "Surround visual selection (lines)" })
			vim.keymap.set("n", "ds", "<Plug>(nvim-surround-delete)", { desc = "Delete surrounding pair" })
			vim.keymap.set("n", "cs", "<Plug>(nvim-surround-change)", { desc = "Change surrounding pair" })
			vim.keymap.set("n", "cl", "<Plug>(nvim-surround-change-line)", { desc = "Change surrounding pair (lines)" })
		end,
	},

	multicursor = {
		"jake-stewart/multicursor.nvim",
		keys = {
			-- -- Add cursor in current cursor
			{
				"<leader>mi",
				function()
					require("multicursor-nvim").toggleCursor()
				end,
				desc = "Multicursor: Add or remove a cursor in current",
			},
			-- -- Add or skip cursor above/below the main cursor
			{
				mode = { "n", "x" },
				"<leader>mk",
				function()
					require("multicursor-nvim").lineAddCursor(-1)
				end,
				desc = "Multicursor: Add cursor above the main cursor",
			},
			{
				mode = { "n", "x" },
				"<leader>mj",
				function()
					require("multicursor-nvim").lineAddCursor(1)
				end,
				desc = "Multicursor: Add cursor below the main cursor",
			},
			{
				mode = { "n", "x" },
				"<leader>msk",
				function()
					require("multicursor-nvim").lineSkipCursor(-1)
				end,
				desc = "Multicursor: Skip cursor above the main cursor",
			},
			{
				mode = { "n", "x" },
				"<leader>lsj",
				function()
					require("multicursor-nvim").lineSkipCursor(1)
				end,
				desc = "Multicursor: Skip cursor below the main cursor",
			},
			-- Add or skip adding a new cursor by matching word/selection
			{
				mode = { "n", "x" },
				"<leader>mw",
				function()
					require("multicursor-nvim").matchAddCursor(1)
				end,
				desc = "AMulticursor: dd adding a new cursor by next matching word/selection",
			},
			{
				mode = { "n", "x" },
				"<leader>msw",
				function()
					require("multicursor-nvim").matchSkipCursor(1)
				end,
				desc = "Multicursor: Skip adding a new cursor next by matching word/selection",
			},
			{
				mode = { "n", "x" },
				"<leader>mW",
				function()
					require("multicursor-nvim").matchAddCursor(-1)
				end,
				desc = "Multicursor: Add adding a new cursor by previous matching word/selection",
			},
			{
				mode = { "n", "x" },
				"<leader>msW",
				function()
					require("multicursor-nvim").matchSkipCursor(-1)
				end,
				desc = "Multicursor: Skip adding a new cursor by previous matching word/selection",
			},
			-- Add and remove cursors with control + left click.
			{
				"<c-leftmouse>",
				function()
					require("multicursor-nvim").handleMouse()
				end,
			},
			{
				"<c-leftdrag>",
				function()
					require("multicursor-nvim").handleMouseDrag()
				end,
			},
			{
				"<c-leftrelease>",
				function()
					require("multicursor-nvim").handleMouseRelease()
				end,
			},
		},
		config = function()
			local mc = require("multicursor-nvim")
			mc.setup()

			-- Mappings defined in a keymap layer only apply when there are
			-- multiple cursors. This lets you have overlapping mappings.
			mc.addKeymapLayer(function(layerSet)
				-- Select a different cursor as the main one.
				layerSet({ "n", "x" }, "<left>", mc.prevCursor)
				layerSet({ "n", "x" }, "<right>", mc.nextCursor)

				-- Delete the main cursor.
				layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

				-- Enable and clear cursors using escape.
				layerSet("n", "<esc>", function()
					if not mc.cursorsEnabled() then
						mc.enableCursors()
					else
						mc.clearCursors()
					end
				end)
			end)

			-- Customize how cursors look.
			local hl = vim.api.nvim_set_hl
			hl(0, "MultiCursorCursor", { link = "Cursor" })
			hl(0, "MultiCursorVisual", { link = "Visual" })
			hl(0, "MultiCursorSign", { link = "SignColumn" })
			hl(0, "MultiCursorMatchPreview", { link = "Search" })
			hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
			hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
			hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
		end,
	},

	{
		"rachartier/tiny-glimmer.nvim",
		keys = { "u", "<c-r>" },
		opts = {
			overwrite = {
				redo = {
					enabled = true,
					default_animation = {
						settings = {
							from_color = "DiffAdd",
						},
					},
				},

				undo = {
					enabled = true,
					default_animation = {
						settings = {
							from_color = "DiffDelete",
						},
					},
				},
			},
		},
	},

	spectre = {
		"nvim-pack/nvim-spectre",
		event = "BufRead",
		keys = {
			{
				mode = "n",
				"<leader>S",
				'<cmd>lua require("spectre").toggle()<CR>',
				{
					desc = "Toggle Spectre",
				},
			},
			{
				mode = "n",
				"<leader>sw",
				'<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
				{
					desc = "Search current word",
				},
			},
			{
				mode = "v",
				"<leader>sw",
				'<esc><cmd>lua require("spectre").open_visual()<CR>',
				{
					desc = "Search current word",
				},
			},
			{
				mode = { "n", "v" },
				"<leader>sp",
				'<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
				{
					desc = "Search on current file",
				},
			},
		},
		config = function()
			require("spectre").setup({})
		end,
	},

	glimmer = {
		"rachartier/tiny-glimmer.nvim",
		keys = { "u", "<c-r>" },
		opts = {
			overwrite = {
				redo = {
					enabled = true,
					default_animation = {
						settings = {
							from_color = "DiffAdd",
						},
					},
				},

				undo = {
					enabled = true,
					default_animation = {
						settings = {
							from_color = "DiffDelete",
						},
					},
				},
			},
		},
	},

	zen = {
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {}
	},

	floaterm = {
		"nvzone/floaterm",
		dependencies = "nvzone/volt",
		opts = {
			terminals = {
				{ name = "Terminal" },
				-- cmd can be function too
				{ name = "Terminal" },
				-- More terminals
			},
		},
		cmd = "FloatermToggle",
	},

	toggleterm = {
		"akinsho/toggleterm.nvim",
		cmd = { "ToggleTerm", "TermExec" },
		keys = {
			{ "<leader>th", "<cmd>ToggleTerm size=15 direction=horizontal<cr>", desc = "Toggle horizontal terminal" },
			{ "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Toggle vertical terminal" },
			{ "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle floating terminal" },
			{ "<leader>tb", "<cmd>ToggleTerm direction=tab<cr>", desc = "Toggle terminal in new tab" },
			{ "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
		},
		config = function()
			require("toggleterm").setup({
				size = function(term)
					if term.direction == "horizontal" then
						return 15
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.3
					end
				end,
				open_mapping = [[<C-\>]],
				hide_numbers = true,
				shade_filetypes = {},
				shade_terminals = true,
				shading_factor = 2,
				start_in_insert = true,
				insert_mappings = true,
				terminal_mappings = true,
				persist_size = true,
				persist_mode = true,
				direction = "float",
				close_on_exit = true,
				shell = vim.o.shell,
				auto_scroll = true,
				float_opts = {
					border = "curved",
					winblend = 0,
					highlights = {
						border = "Normal",
						background = "Normal",
					},
				},
				winbar = {
					enabled = false,
					name_formatter = function(term)
						return term.name
					end
				},
			})

			-- Terminal mode mappings
			function _G.set_terminal_keymaps()
				local opts = {buffer = 0}
				vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
				vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
				vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
				vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
			end

			vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
			
			-- Custom terminal functions
			local Terminal = require('toggleterm.terminal').Terminal
			
			-- Lazygit integration
			local lazygit = Terminal:new({
				cmd = "lazygit",
				dir = "git_dir",
				direction = "float",
				float_opts = {
					border = "double",
				},
				on_open = function(term)
					vim.cmd("startinsert!")
					vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
				end,
				on_close = function(term)
					vim.cmd("startinsert!")
				end,
			})

			function _LAZYGIT_TOGGLE()
				lazygit:toggle()
			end

			-- Node REPL
			local node = Terminal:new({ cmd = "node", hidden = true })
			function _NODE_TOGGLE()
				node:toggle()
			end

			-- Python REPL
			local python = Terminal:new({ cmd = "python3", hidden = true })
			function _PYTHON_TOGGLE()
				python:toggle()
			end

			-- Htop
			local htop = Terminal:new({ cmd = "htop", hidden = true })
			function _HTOP_TOGGLE()
				htop:toggle()
			end

			-- Custom keymaps for specialized terminals
			vim.keymap.set('n', '<leader>gg', '<cmd>lua _LAZYGIT_TOGGLE()<CR>', { desc = "Toggle LazyGit" })
			vim.keymap.set('n', '<leader>tn', '<cmd>lua _NODE_TOGGLE()<CR>', { desc = "Toggle Node REPL" })
			vim.keymap.set('n', '<leader>tp', '<cmd>lua _PYTHON_TOGGLE()<CR>', { desc = "Toggle Python REPL" })
			vim.keymap.set('n', '<leader>th', '<cmd>lua _HTOP_TOGGLE()<CR>', { desc = "Toggle Htop" })
		end,
	},

	im_select = {
		"SilverofLight/im-select.nvim",
		event = "VeryLazy",
		config = function()
			require("im_select").setup({
				hybrid_mode = true,
				default_im_select = vim.fn.expand("~/.local/bin/im-select"),
				set_default_events = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },
				set_previous_events = { "InsertEnter" },
				disable_auto_restore = false,
			})
		end,
	},

	hardtime = {
		"m4xshen/hardtime.nvim",
		cmd = "Hardtime",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			max_count = 30,
		},
	},
}

return M
