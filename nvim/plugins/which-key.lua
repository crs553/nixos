
-- nvim/plugins/which-key.lua
local wk = require("which-key")

wk.setup({
})
wk.add({
  {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
  },
})
