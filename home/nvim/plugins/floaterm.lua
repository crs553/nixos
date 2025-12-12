
local wk = require("which-key")
wk.add({
  {
    "<M-i>",
    "<cmd>FloatermToggle<CR>",
    mode = "n",
    desc = "Toggle Floaterm",
  },
  {
    "<M-i>",
    [[<C-\><C-n><cmd>FloatermToggle<CR>]],
    mode = "t",
    desc = "Toggle Floaterm",
  },
})

-- Floaterm configuration
vim.g.floaterm_width = 0.9
vim.g.floaterm_height = 0.9
vim.g.floaterm_wintype = "float"
vim.g.floaterm_borderchars = "─│─│╭╮╯╰"


