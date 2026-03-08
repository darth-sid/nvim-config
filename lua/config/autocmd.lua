--run formatter on save
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern='*.py',
    callback=function()
        vim.lsp.buf.format({ async=false, name='ruff' })
    end,
})
--prettify json buffers on open (display only, preserves file on disk)
vim.api.nvim_create_autocmd('BufReadPost', {
    pattern='*.json',
    callback=function()
        vim.cmd(':%!jq .')
        vim.cmd('set nomodified')
    end,
})
--remove comment continuation on enter and o
vim.api.nvim_create_autocmd('FileType', {
    pattern='*',
    callback=function()
        vim.cmd('set formatoptions-=cro')
    end,
})
--ignore term buffer
vim.api.nvim_create_autocmd('TermOpen', {
    pattern='*',
    callback=function()
        vim.cmd('setlocal nobuflisted')
    end,

})
