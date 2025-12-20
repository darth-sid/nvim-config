return {
    {
        'machakann/vim-sandwich',
        lazy=false,
    },
    {
        'windwp/nvim-autopairs',
        lazy=true,
        event = "InsertEnter",
        opts={},
    },
    {
        'nvim-focus/focus.nvim',
        lazy=true,
        cmd = {
            'FocusEnable',
        },
        version = '*',
        opts={
            autoresize = {
                minheight = 8,
                minwidth = 20,
            }
        },
    },
}
