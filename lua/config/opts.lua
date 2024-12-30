options = {
    showmatch = true,
    smartcase = true,
    tabstop=4,
    softtabstop=4,
    expandtab=true,
    shiftwidth=4,
    autoindent=true,
    wrap=false,
    number=true,
    wildmode="longest,list",
    mouse="n",
    termguicolors=true,
    cursorline=true,
    winblend=10,
    colorcolumn="80," .. table.concat(vim.fn.range(120, 500), ","),
}

for opt, val in pairs(options) do
    vim.opt[opt] = val 
end

--disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "
