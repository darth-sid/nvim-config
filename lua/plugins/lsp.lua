return {
    {
        'williamboman/mason.nvim',
        lazy=false,
        opts={},
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
                'golangci-lint',
                'java_language_server',
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
            local lsp = require('lspconfig')
            local coq = require('coq')
            -- python 
            -- TODO: revisit pyright ruff coexistence
            lsp.pyright.setup{coq.lsp_ensure_capabilities{
                on_attach = function(client, _)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end
            }}
            lsp.ruff.setup{coq.lsp_ensure_capabilities{
                on_attach = function(client, _)
                    client.server_capabilities.documentFormattingProvider = true
                    client.server_capabilities.documentRangeFormattingProvider = true
                    client.server_capabilities.hoverProvider = false
                    client.server_capabilities.definitionProvider = false
                end
            }}
            -- ts & vue
            lsp.ts_ls.setup{coq.lsp_ensure_capabilities{
                filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact'},
                init_options = {
                    documentFormatting = false,
                },
            }}

            lsp.volar.setup{coq.lsp_ensure_capabilities{
                filetypes = { 'vue' },
                init_options = {
                    vue = {
                        hybridMode = false,
                    },
                    typescript = {
                        tsdk = vim.fn.getcwd() .. '/node_modules/typescript/lib',
                    },
                },
            }}

            lsp.rust_analyzer.setup{coq.lsp_ensure_capabilities{
                filetypes = { 'rust' },
                settings = {
                    ['rust-analyzer'] = {
                        cargo = {
                            allFeatures = true,
                        },
                        checkOnSave = {
                            command = "clippy",
                        },
                    },
                },
            }}

            lsp.gopls.setup{coq.lsp_ensure_capabilities{}}

            require('coq_3p') {
                {src = 'bc', short_name = 'MATH', precision = 6} -- scientific calculator
            }
        end,
    }
}
