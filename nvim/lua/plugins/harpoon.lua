return {
  "theprimeagen/harpoon",
  branch = "harpoon2",
  opts = {
    settings = {
      save_on_toggle = true,       -- enable saving harpoon menu on toggling
    }
  },
  config = function(_, opts)
    local harpoon = require("harpoon")
    harpoon:setup(opts)

    -- open & add functions
    vim.keymap.set("n", "<leader>A", function() harpoon:list():prepend() end)
    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    -- switching function
    vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)

    -- replacing function
    vim.keymap.set("n", "<leader><C-h>", function() harpoon:list():replace_at(1) end)
    vim.keymap.set("n", "<leader><C-j>", function() harpoon:list():replace_at(2) end)
    vim.keymap.set("n", "<leader><C-k>", function() harpoon:list():replace_at(3) end)
    vim.keymap.set("n", "<leader><C-l>", function() harpoon:list():replace_at(4) end)
  end
}
