require('legendary').setup({
  include_builtin = true,
  include_legendary_cmds = true,
  most_recent_item_at_top = true,
  keymaps = {
    { '<C-p>', require('legendary').find, description = "Command Palette", mode = {'n', 'i', 'x'}},
    {'<leader>ff', '<cmd>Telescope find_files<CR>', description = 'Find files'},
    {'<leader>fg', '<cmd>Telescope live_grep<CR>', description = 'Live grep'},
    {'<leader>fb', '<cmd>Telescope buffers<CR>', description = 'View buffers'},
    {'<leader>fh', '<cmd>Telescope help_tags<CR>', description = 'Help'},
    {'<leader>ft', '<cmd>NvimTreeToggle<CR>', description = 'Toggle NvimTree'},
  }
})
