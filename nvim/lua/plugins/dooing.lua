return {
  {
    "atiladefreitas/dooing",
    opts = {
      save_path = vim.fn.expand("~/Documents/notes/dooing_todos.json"),
      window = {
        width = 60,
        height = 20,
        border = "rounded",
      },
      icons = {
        pending = "○",
        done = "✓",
      },
      keymaps = {
        toggle_window = "<A-t>", -- Alt+t to open/close
        new_todo      = "i",
        toggle_todo   = "x",
        delete_todo   = "d",
        close_window  = "q",
      },
    },
    config = function(_, opts)
      require("dooing").setup(opts)
    end,
    keys = {
      { "<A-t>", "<cmd>Dooing<CR>", desc = "Toggle Dooing todos" },
    },
  },
}
