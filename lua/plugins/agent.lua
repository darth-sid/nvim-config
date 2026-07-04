return {
    'darth-sid/agent-nvim',
    -- dir = "~/code/personal/projects/WIP/nvim-plugin/agent-nvim", -- dev
    config = function()
        require("agent").setup({
            default_agent = 'claude',
            split = 'vertical',
        })
    end,
}
