return {
    {
        'tpope/vim-fugitive',
        lazy=true, -- only load when used
        cmd = {
            'G',
            'Git',
        },
        keys = {
            {'<leader>gs', '<cmd>Git status<cr>'},
            {'<leader>ga', '<cmd>Git add %<cr>'},
            {'<leader>gd', '<cmd>Git diff %<cr>'},
            {'<leader>gc', ':Git commit -m '},
            {'<leader>gl', '<cmd>Git log<cr>'},
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        lazy=false,
        opts={},
    },
}
