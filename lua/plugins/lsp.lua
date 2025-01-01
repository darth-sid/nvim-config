return {
    {
        'williamboman/mason.nvim',
        lazy=false,
        opts={},
    },
    {
        'williamboman/mason-lspconfig.nvim',
        lazy=false,
        opts={
            ensure_installed = {
                'pyright', -- advanced python ( type checking, etc )
                'ruff', -- fast python linting and formatting
                'ts_ls', -- ts lsp
                'eslint', -- js/ts linting and formatting
                'volar', -- vue lsp
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        lazy=false,
        dependencies = {
            {'williamboman/mason.nvim'},
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
            -- TODO: clean up pyright ruff coexistence
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
            -- TODO: verify vue support
            -- TODO: fix eslint
            lsp.ts_ls.setup{
                init_options = {
                    documentFormatting = false,
                },
                filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact'},
            }
            lsp.volar.setup{
                filetypes = { 'vue' },
                init_options = {
                    vue = {
                        hybridMpde = false,
                    },
                    typescript = {
                        tsdk = '/opt/homebrew/lib/node_modules/typescript/lib',
                    },
                },
            }

            lsp.eslint.setup{
                on_attach = function(client, bufnr)
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        command = "EslintFixAll",
                    })
                end,
            }

            require('coq_3p') {
                {src = 'bc', short_name = 'MATH', precision = 6} -- scientific calculator
            }
        end,
    }
}
