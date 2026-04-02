-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "nvim-lua/plenary.nvim",

  -- Theme: load first at startup before other plugins
  {
    "mcchrish/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("user.theme")
    end,
  },

  -- Treesitter: load when opening a buffer
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    config = function()
      require("user.treesitter")
    end,
  },

  -- Clojure
  "Olical/conjure",

  -- Which Key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup {}
    end,
  },

  -- Legendary: load eagerly so keymaps register at startup
  {
    "mrjones2014/legendary.nvim",
    lazy = false,
    config = function()
      require("user.legendary")
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
  },

  -- Dressing
  {
    "stevearc/dressing.nvim",
    lazy = false,
  },

  -- Database
  "tpope/vim-dadbod",
  "kristijanhusak/vim-dadbod-ui",

  -- File tree
  "nvim-tree/nvim-web-devicons",
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("user.nvim-tree")
    end,
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("user.toggleterm")
    end,
  },
})

vim.g.db_ui_save_location = '~/.config/db-ui'
