--run formatter on save
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern='*.py',
    callback=function()
        vim.lsp.buf.format({async=true})
    end,
})
--prettify json files
vim.api.nvim_create_autocmd('FileType', {
    pattern='json',
    callback=function()
        vim.cmd(':%!jq .')
    end,
})
--remove comment continuation on enter and o
vim.api.nvim_create_autocmd('FileType', {
    pattern='*',
    callback=function()
        vim.cmd('set formatoptions-=cro')
    end,
})
