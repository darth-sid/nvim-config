return {
    'kevinhwang91/nvim-ufo', 
    lazy=true,
    dependencies = {
        'kevinhwang91/promise-async',
        'neovim/nvim-lspconfig',
    },
    keys = { -- load when folds opened/closed
        { "zM", function() require("ufo").closeAllFolds() end, desc = "󱃄 Close All Folds" },
        { "zr", function() require("ufo").openFoldsExceptKinds { "comment", "imports" } end, desc = "󱃄 Open All Regular Folds" },
        { "zR", function() require("ufo").openAllFolds() end, desc = "󱃄 Open All Folds" },
        { 'za' },
        { 'zo' },
        { 'zc' },
        { 'zm' },
	},
    cmds = { -- load when cmds used
        'UfoInspect',
        'UfoAttach',
        'UfoEnable',
    },
    init = function()
        vim.opt.foldcolumn='0' -- show fold levels on left (0 for off)
		vim.opt.foldlevel = 99 
		vim.opt.foldlevelstart = 99
        vim.opt.foldenable=true

	end,
    config = function()
        -- use nvim-lspconfig to detect folds
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }
        local lsp = require('lspconfig')
        local language_servers = lsp.util.available_servers()
        for _, ls in ipairs(language_servers) do
            lsp[ls].setup({
                capabilities = capabilities
            })
        end
       
        require('ufo').setup()
    end
}
