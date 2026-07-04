return {
    {
        'williamboman/mason.nvim',
        lazy=false,
        -- NOTE: mason.nvim itself ignores `ensure_installed`; need mason-tool-installer.nvim
        -- for non-LSP tools like golangci-lint.
        opts={
            -- ensure_installed = {
            --     'golangci-lint',
            -- },
        },
    },
    {
        'williamboman/mason-lspconfig.nvim',
        lazy=false,
        dependencies = {
            {'williamboman/mason.nvim'},
        },
        opts={
            ensure_installed = {
                'pyright', -- advanced python ( type checking, etc )
                'ruff', -- fast python linting and formatting
                'ts_ls', -- ts lsp
                'volar', -- vue lsp
                'rust_analyzer', -- rust lsp
                'gopls', -- go lsp
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        lazy=false,
        dependencies = {
            {'williamboman/mason-lspconfig.nvim'},
            {'ms-jpq/coq_nvim', branch='coq'},
            {'ms-jpq/coq.artifacts', branch='artifacts'},
            {'ms-jpq/coq.thirdparty', branch='3p'},
        },
        init=function()
            vim.g.coq_settings = {
                keymap = {
                    jump_to_mark='',
                    bigger_preview='',
                },
                auto_start=true,
                clients = { -- custom coq short names
                    ['snippets.short_name'] = 'SNIP',
                    ['buffers.short_name'] = 'BUF',
                    ['lsp.short_name'] = 'LSP',
                    ['lsp_inline.short_name'] = 'COP',
                    ['registers.short_name'] = 'REG',
                    ['tmux.short_name'] = 'TMUX',
                }
            }
        end,
        config=function()
            local coq = require('coq')
            -- python
            -- TODO: revisit pyright ruff coexistence
            vim.lsp.config('pyright', coq.lsp_ensure_capabilities{
                on_attach = function(client, _)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end
            })
            vim.lsp.config('ruff', coq.lsp_ensure_capabilities{
                on_attach = function(client, _)
                    client.server_capabilities.documentFormattingProvider = true
                    client.server_capabilities.documentRangeFormattingProvider = true
                    client.server_capabilities.hoverProvider = false
                    client.server_capabilities.definitionProvider = false
                end
            })
            -- ts & vue
            vim.lsp.config('ts_ls', coq.lsp_ensure_capabilities{
                filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact'},
                init_options = {
                    documentFormatting = false,
                },
            })

            vim.lsp.config('volar', coq.lsp_ensure_capabilities{
                filetypes = { 'vue' },
                init_options = {
                    vue = {
                        hybridMode = false,
                    },
                    typescript = {
                        tsdk = vim.fn.getcwd() .. '/node_modules/typescript/lib',
                    },
                },
            })

            vim.lsp.config('rust_analyzer', coq.lsp_ensure_capabilities{
                filetypes = { 'rust' },
                settings = {
                    ['rust-analyzer'] = {
                        cargo = {
                            allFeatures = true,
                        },
                        checkOnSave = true,
                        check = {
                            command = "clippy",
                        },
                    },
                },
            })

            vim.lsp.config('gopls', coq.lsp_ensure_capabilities{})

            vim.lsp.enable({'pyright', 'ruff', 'ts_ls', 'volar', 'rust_analyzer', 'gopls'})

            require('coq_3p') {
                {src = 'bc', short_name = 'MATH', precision = 6} -- scientific calculator
            }
        end,
    }
}
