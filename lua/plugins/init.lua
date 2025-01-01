return {
    {
        'vim-python/python-syntax',
        lazy=false,
        ft={'python'},
        init=function()
            vim.g.python_highlight_all = 1
        end,
    },
}
