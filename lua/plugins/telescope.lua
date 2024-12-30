return {
    'nvim-telescope/telescope.nvim',
    lazy=true,
    branch='0.1.x',
    dependencies={
        'nvim-lua/plenary.nvim',
        'BurntSushi/ripgrep', -- for livegrep
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
}
