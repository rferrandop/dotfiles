return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "stevearc/conform.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "j-hui/fidget.nvim",
            "williamboman/mason.nvim"
        },

        config = function()
            require("mason").setup()

            require("conform").setup({
                formatters_by_ft = {
                }
            })
            local lspconfig = require('lspconfig')
            local cmp = require('cmp')
            local cmp_lsp = require("cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities())

            require("fidget").setup({})

            lspconfig.lua_ls.setup {
                cmd = { "lua-language-server" },
                capabilities = capabilities,
                diagnostics = {
                    globals = { 'vim' },
                }
            }

            lspconfig.rust_analyzer.setup {
                cmd = { "rust-analyzer" },
                capabilities = capabilities,
            }

            lspconfig.csharp_ls.setup {
                cmd = { "csharp-ls" },
                capabilities = capabilities,
            }

            lspconfig.clangd.setup {
                cmd = { "clangd" },
                capabilities = capabilities,
            }

            lspconfig.nil_ls.setup {
                cmd = { "nil" },
                capabilities = capabilities,
            }

            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- For luasnip users.
                }, {
                    { name = 'buffer' },
                })
            })

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

            local map = vim.keymap.set
            local opts = nil;
            map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
            map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
            map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
            map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
            map("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
            map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
            map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
            map("n", "gR", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
            map({ "n", "x" }, "cf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
            map("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

            map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
            map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
            map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
        end
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    }
}
