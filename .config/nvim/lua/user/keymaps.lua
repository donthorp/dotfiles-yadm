local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local km = vim.api.nvim_set_keymap

-- Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ","

km("n", "<Space>", "<Nop>", opts)

-- Normal Mode: window navigation
km("n", "<C-h>", "<C-w>h", opts)
km("n", "<C-j>", "<C-w>j", opts)
km("n", "<C-k>", "<C-w>k", opts)
km("n", "<C-l>", "<C-w>l", opts)

-- Visual Mode: stay in indent mode
km("v", "<", "<gv", opts)
km("v", ">", ">gv", opts)

-- Terminal Mode: window navigation
km("t", "<C-h>", "C-\\><C-N><C-w>h", term_opts)
km("t", "<C-j>", "C-\\><C-N><C-w>j", term_opts)
km("t", "<C-k>", "C-\\><C-N><C-w>k", term_opts)
km("t", "<C-l>", "C-\\><C-N><C-w>l", term_opts)

-- Database: DadBod
km("n", "<leader>du", ":DBUIToggle<CR>", opts)
km("n", "<leader>df", ":DBUIFindBuffer<CR>", opts)
km("n", "<leader>dr", ":DBUIiRenameBuffer<CR>", opts)
km("n", "<leader>dl", ":DBUILastQueryInfo<CR>", opts)

-- Telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>",  { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>",    { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>",  { desc = "Help" })

-- File tree
vim.keymap.set("n", "<leader>ft", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

-- Command palette
vim.keymap.set({"n", "i", "x"}, "<C-p>", function() require("legendary").find() end, { desc = "Command palette" })
