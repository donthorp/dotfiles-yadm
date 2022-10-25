local opts = { 
  noremap = true,
  silent = true,
}

local term_opts = {
  silent = true
}

-- Shorten function name
local km = vim.api.nvim_set_keymap

-- Remap space as leader key
-- km("n", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Normal Mode
-- Easier window navigation

km("n", "<C-h>", "<C-w>h", opts)
km("n", "<C-j>", "<C-w>j", opts)
km("n", "<C-k>", "<C-w>k", opts)
km("n", "<C-l>", "<C-w>l", opts)

-- Visual Mode
-- Stay in indent mode

km("v", "<", "<gv", opts)
km("v", ">", ">gv", opts)

-- Terminal Mode
-- Better terminal navigation

km("t", "<C-h>", "C-\\><C-N><C-w>h", term_opts)
km("t", "<C-j>", "C-\\><C-N><C-w>j", term_opts)
km("t", "<C-k>", "C-\\><C-N><C-w>k", term_opts)
km("t", "<C-l>", "C-\\><C-N><C-w>l", term_opts)

-- Database: DadBod

km("n", "<leader>du", ":DBUIToggle<CR>", opts)
km("n", "<leader>df", ":DBUIFindBuffer<CR>", opts)
km("n", "<leader>dr", ":DBUIiRenameBuffer<CR>", opts)
km("n", "<leader>dl", ":DBUILastQueryInfo<CR>", opts)

-- Legendary Configurations
require('legendary').setup()

-- Which Key Configurations
local wk = require("which-key")

wk.setup { }

