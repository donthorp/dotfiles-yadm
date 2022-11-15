-- :help options
--
-- https://github.com/LunarVim/Neovim-from-scratch was the source that used this technique

-- Disable Nerd Tree (Using nvim-tree.lua instead)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Visual Settings

local set = vim.opt

set.termguicolors = true
set.background = 'light'

set.syntax = 'on'
set.number = true
set.numberwidth = 4

-- Encoding

set.encoding = "utf-8"
set.fileencoding = "utf-8"
set.fileencodings = "utf-8"
set.ttyfast = true

-- Fix backspace indent

set.backspace = "indent,eol,start"

-- Tabs

set.tabstop=2
set.softtabstop = 0
set.shiftwidth = 2
set.expandtab = true
set.smartindent = true

-- Mouse Options
set.mouse = 'nv'

-- Window Options

set.splitbelow = true -- Horizontals open below current window
set.splitright = true -- Verticals open to the right of the current window

-- Set leader timeout (ms)
set.timeoutlen = 300

