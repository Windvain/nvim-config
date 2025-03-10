return {
	"neovim/nvim-lspconfig",
	dependencies = { "hrsh7th/nvim-cmp", "hrsh7th/cmp-nvim-lsp" },

	config = function()
		local lspconf = require("lspconfig")
		local lspconf_defaults = lspconf.util.default_config
		local cmp = require("cmp")

		lspconf_defaults.capabilities = vim.tbl_deep_extend(
		    "force",
		    lspconf_defaults.capabilities,
		    require("cmp_nvim_lsp").default_capabilities()
		)

		lspconf.cmake.setup({})
		lspconf.ccls.setup{
			name = "ccls",

			autostart = true,
			single_file_support = false,	-- Enabling this makes all C++ projects with more than one file fail.
			silent = false,

			init_options = {
				compilationDatabaseDirectory = "build"
			},

			root_dir = lspconf.util.root_pattern(
				".git",
				".editorconfig",
				".clang-format"
			)
		}

		cmp.setup({
			sources = { name = "nvim_lsp" },
			snippet = {
				expand = function(args)
					vim.snippet.expand(args.body)
				end
			},

			mapping = cmp.mapping.preset.insert({
				["<Up>"] = cmp.mapping.select_prev_item(),
				["<Down>"] = cmp.mapping.select_next_item(),
				["<Esc>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true })
			})
		})
	end
}
