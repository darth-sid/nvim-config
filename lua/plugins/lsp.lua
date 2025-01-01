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
                on_attach = function(client, buf)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end
            }}
            lsp.ruff.setup{coq.lsp_ensure_capabilities{
                on_attach = function(client, buf) 
                    client.server_capabilities.documentFormattingProvider = true
                    client.server_capabilities.documentRangeFormattingProvider = true
                    client.server_capabilities.hoverProvider = false
                    client.server_capabilities.definitionProvider = false
                end
            }}
            -- ts & vue
            lsp.ts_ls.setup{
                filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact'},
                init_options = {
                    documentFormatting = false,
                },
            }

            lsp.volar.setup{
                filetypes = { 'vue' },
                init_options = {
                    vue = {
                        hybridMode = false,
                    },
                    typescript = {
                        tsdk = vim.fn.getcwd() .. '/node_modules/typescript/lib',
                    },
                },
            }

            require('coq_3p') {
                {src = 'bc', short_name = 'MATH', precision = 6} -- scientific calculator
            }
        end,
    }
}
