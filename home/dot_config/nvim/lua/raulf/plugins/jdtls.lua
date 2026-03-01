return {
    {
        "mfussenegger/nvim-jdtls",
        ft = 'java',
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        config = function()
            local jdtls = require("jdtls")

            local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
            local root_dir = require("jdtls.setup").find_root(root_markers)
            if not root_dir then return end

            local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
            local workspace_dir = vim.fn.stdpath("data") .. "/jdtls/workspaces/" .. project_name

            -- Use Nix-provided jdtls
            local jdtls_bin = vim.fn.exepath("jdtls") or "jdtls"

            local config = {
                cmd = { jdtls_bin, "-data", workspace_dir },
                root_dir = root_dir,
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
                settings = {
                    java = {
                        import = {
                            exclusions = {
                                "**/.devenv/**",
                                "**/node_modules/**",
                                "**/.metadata/**",
                                "**/build/**",
                                "**/generated/**",
                                "**/tmp/**",
                            },
                        },
                        project = {
                            resourceFilters = {
                                "\\.devenv",
                                "node_modules",
                                "\\.git",
                                "build",
                                "generated",
                                "tmp",
                            },
                        },
                    },
                },
            }

            jdtls.start_or_attach(config)
        end
    }
}
