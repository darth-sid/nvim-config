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
}
