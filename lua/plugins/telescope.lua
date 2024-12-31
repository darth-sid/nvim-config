return {
    'nvim-telescope/telescope.nvim',
    lazy=true,
    branch='0.1.x',
    dependencies={
        {'nvim-lua/plenary.nvim'},
        {'BurntSushi/ripgrep'}, -- for livegrep
        { 'nvim-telescope/telescope-fzf-native.nvim',
            build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
    },
    cmd='Telescope',
    keys={
        {'<leader>ff', '<cmd>Telescope find_files<cr>'},
        {'<leader>fg', '<cmd>Telescope live_grep<cr>'},
        {'<leader>fb', '<cmd>Telescope buffers<cr>'},
        {'<leader>fh', '<cmd>Telescope help_tags<cr>'},
    },
    init = function()
        vim.api.nvim_create_autocmd('VimEnter', {
            callback=function()
                if vim.fn.argc() == 0 then
                    require('telescope.builtin').find_files()
                end
            end
        })
    end,
    config = function()
        local telescope = require('telescope')
        telescope.setup{
            defaults = {
                file_ignore_patterns = {
                    '.git/',
                    'node_modules/',
                    'build/',
                },
                mappings = {
                    i = {
                        ['<esc>'] = require('telescope.actions').close,
                    },
                },
            },
            extensinos = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = 'smart_case',
                },
            },
        }
        telescope.load_extension('fzf')
    end
}
