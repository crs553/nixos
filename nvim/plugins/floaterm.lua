local wk = require("which-key")
local floaterm = require("floaterm")

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

