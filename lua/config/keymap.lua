default_opts = {noremap=true, silent=true}

mappings = {
    {'n', "<Space>", "<Nop>", default_opts},
    --jump between panes
    {'n', "<C-h>", "<C-w>h", default_opts},
    {'n', "<C-j>", "<C-w>j", default_opts},
    {'n', "<C-k>", "<C-w>k", default_opts},
    {'n', "<C-l>", "<C-w>l", default_opts},
    --move panes
    {'n', "<M-h>", "<C-w>H", default_opts},
    {'n', "<M-j>", "<C-w>J", default_opts},
    {'n', "<M-k>", "<C-w>K", default_opts},
    {'n', "<M-l>", "<C-w>L", default_opts},
    --buffer util
    {'n', '<leader>l', '<cmd>bn<cr>', default_opts},
    {'n', '<leader>h', '<cmd>bp<cr>', default_opts},
    {'n', '<leader>x', '<cmd>bp|sp|bn|bd<cr>', default_opts},
    --clipboard copy
    {"n", "<leader>y", "\"+y", default_opts},
    {"v", "<leader>y", "\"+y", default_opts},
    {"n", "<leader>Y", "\"+Y", default_opts},
    --splits
    {'n', '<leader>v', '<cmd>vsp<cr>', default_opts},
    {'n', '<leader>s', '<cmd>sp<cr>', default_opts},
    --cmd shortcuts
    {'n', '<leader>w', '<cmd>w<cr>', default_opts},
    {'n', '<leader>q', '<cmd>qa<cr>', default_opts},

}

for _, map in ipairs(mappings) do
    vim.api.nvim_set_keymap(map[1], map[2], map[3], map[4])
end

hard_mappings = {
    --disable arrow keys
    {'v', '<Left>', '<cmd>echoe "Use h"<cr>', default_opts},
    {'v', '<Right>', '<cmd>echoe "Use l"<cr>', default_opts},
    {'v', '<Up>', '<cmd>echoe "Use k"<cr>', default_opts},
    {'v', '<Down>', '<cmd>echoe "Use j"<cr>', default_opts},
    {'n', '<Left>', '<cmd>echoe "Use h"<cr>', default_opts},
    {'n', '<Right>', '<cmd>echoe "Use l"<cr>', default_opts},
    {'n', '<Up>', '<cmd>echoe "Use k"<cr>', default_opts},
    {'n', '<Down>', '<cmd>echoe "Use j"<cr>', default_opts},
    {'i', '<Left>', '<cmd>echoe "Use h"<cr>', default_opts},
    {'i', '<Right>', '<cmd>echoe "Use l"<cr>', default_opts},
    {'i', '<Up>', '<cmd>echoe "Use k"<cr>', default_opts},
    {'i', '<Down>', '<cmd>echoe "Use j"<cr>', default_opts},
}

local hard = true

if hard then
    for _, map in ipairs(hard_mappings) do
        vim.api.nvim_set_keymap(map[1], map[2], map[3], map[4])
    end
end
