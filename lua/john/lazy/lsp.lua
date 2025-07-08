return {
	'neovim/nvim-lspconfig',
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},

	config = function()
		vim.api.nvim_create_autocmd('LspAttach', {
			desc = 'LSP actions',
			callback = function(event)
				local opts = {buffer = event.buf}

				vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
				vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
				vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
				vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
				vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
				vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
				vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
				vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
				vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
				vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

                -- show errors
				vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float(0, {scope="line"})<cr>', opts)
			end,
		})

		local cmp = require('cmp')
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
        )
		cmp.setup({
			sources = {
				{name = 'nvim_lsp'},
			},
			mapping = cmp.mapping.preset.insert({
				-- `Enter` key to confirm completion
				['<CR>'] = cmp.mapping.confirm({select = false}),

				-- Ctrl+Space to trigger completion menu
				['<C-Space>'] = cmp.mapping.complete(),

				-- Scroll up and down in the completion documentation
				['<C-u>'] = cmp.mapping.scroll_docs(-4),
				['<C-d>'] = cmp.mapping.scroll_docs(4),
                ['<Tab>'] = cmp.mapping.select_next_item(),
                ['<S-Tab>'] = cmp.mapping.select_prev_item(),
			}),
			snippet = {
				expand = function(args)
					vim.snippet.expand(args.body)
				end,
			},

			vim.diagnostic.config({
				-- update_in_insert = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})

		})

		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"jdtls",
                "intelephense",
                "html",
                "cssls",
                "ts_ls",
                "clangd",
                "eslint",
                "sqlls",
				-- "rust_analyzer",
				-- "gopls",
			},
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup {
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" },
                                }
                            }
                        }
                    }
                end,
                ["jdtls"] = function ()
                    require("lspconfig").jdtls.setup({
                        handlers = {
                            ['language/status'] = function(_, result)
                            end,
                            ['$/progress'] = function(_, result, ctx)
                            end,
                        },
                    })
                end,
            }
        })
    end
}
