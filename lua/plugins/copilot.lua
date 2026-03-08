-- TODO: consider switching to github/copilot.vim to use copilot as a coq source instead
return {
    'zbirenbaum/copilot.lua',
    lazy=true,
    cmd="Copilot",
    event="InsertEnter",
    opts={
        suggestion = {
            auto_trigger = true,
            keymap = {
                accept = '<M-l>',  -- separate from coq's Tab
                dismiss = '<M-]>',
            },
        },
        panel = { enabled = false },
    },
}
