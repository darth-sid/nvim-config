return {'neovim/nvim-lspconfig',
    lazy=false,
    dependencies = {
        {'ms-jpq/coq_nvim', branch='coq'},
        {'ms-jpq/coq.artifacts', branch='artifacts'},
        {'ms-jpq/coq.thirdparty', branch='3p'},
        {'astral-sh/ruff'},
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
        local vue_language_server_path = '/opt/homebrew/lib/node_modules/@vue/language-server'
        lsp.ts_ls.setup{
            init_options = {
                documentFormatting = false,
                plugins = {
                    {
                        name='@vue/typescript-plugin',
                        location=vue_language_server_path,
                        languages={'vue'},
                    },
                },
            },
            filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        }
        lsp.eslint.setup{
            on_attach = function(client, bufnr)
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    command = "EslintFixAll",
                })
            end,
        }
        lsp.volar.setup{}

        require('coq_3p') {
            {src = 'bc', short_name = 'MATH', precision = 6} -- scientific calculator
        }
    end,
}
