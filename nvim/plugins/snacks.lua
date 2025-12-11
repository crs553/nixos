-- nvim/plugins/snacks.lua
local Snacks = require("snacks")

-- Main setup
Snacks.setup({
  bigfile = { enabled = true },
  dashboard = {
    enabled = true,
    preset = {
      header = [[
 ________________           
|   |,"    `.|   |           
|   /  SONY  \\   |          
|O _\\   />   /_  |   ___ _  
|_(_)'.____.'(_)_|  (")__(")
[___|[=]__[=]|___]  //    \\\\]],
    },
    opts = { hide = { statusline = false } },
    formats = {
      header = { align = "center" },
      key = function(item)
        return {
          { "[", hl = "Special" },
          { item.key, hl = "Identifier" },
          { "]", hl = "Special" },
        }
      end,
    },
    sections = {
      { section = "header" },
      { section = "keys", gap = 1, padding = 1 },
      { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
      { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
      { pane = 2, height = 16, section = "terminal", cmd = "fortune", padding = 1 },
    },
  },
  explorer = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  notifier = { enabled = true, timeout = 3000 },
  picker = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
  styles = { notification = { wo = { wrap = true } } },
})

-- Key mappings
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Top Pickers & Explorer
map("n", "<leader>,", Snacks.picker.buffers, { desc = "Buffers" })
map("n", "<leader>:", Snacks.picker.command_history, { desc = "Command History" })
map("n", "<leader>n", Snacks.picker.notifications, { desc = "Notification History" })
map("n", "<leader>e", Snacks.explorer, { desc = "File Explorer" })

-- Find
map("n", "<leader>fb", Snacks.picker.buffers, { desc = "Buffers" })
map("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find Config File" })
map("n", "<leader>fd", Snacks.picker.files, { desc = "Find Files" })
map("n", "<leader>fg", Snacks.picker.git_files, { desc = "Find Git Files" })
map("n", "<leader>fp", Snacks.picker.projects, { desc = "Projects" })
map("n", "<leader>fr", Snacks.picker.recent, { desc = "Recent" })
map("n", "<leader>fs", Snacks.picker.grep, { desc = "Grep" })
map("n", "<leader>fh", Snacks.picker.help, { desc = "Help Pages" })

-- Git
map("n", "<leader>gb", Snacks.picker.git_branches, { desc = "Git Branches" })
map("n", "<leader>gl", Snacks.picker.git_log, { desc = "Git Log" })
map("n", "<leader>gL", Snacks.picker.git_log_line, { desc = "Git Log Line" })
map("n", "<leader>gs", Snacks.picker.git_status, { desc = "Git Status" })
map("n", "<leader>gS", Snacks.picker.git_stash, { desc = "Git Stash" })
map("n", "<leader>gd", Snacks.picker.git_diff, { desc = "Git Diff (Hunks)" })
map("n", "<leader>gf", Snacks.picker.git_log_file, { desc = "Git Log File" })

-- Grep/Search
map("n", "<leader>sb", Snacks.picker.lines, { desc = "Buffer Lines" })
map("n", "<leader>sB", Snacks.picker.grep_buffers, { desc = "Grep Open Buffers" })
map({"n","x"}, "<leader>sw", Snacks.picker.grep_word, { desc = "Visual selection or word" })
map("n", '<leader>s"', Snacks.picker.registers, { desc = "Registers" })
map("n", "<leader>s/", Snacks.picker.search_history, { desc = "Search History" })
map("n", "<leader>sa", Snacks.picker.autocmds, { desc = "Autocmds" })
map("n", "<leader>sc", Snacks.picker.command_history, { desc = "Command History" })
map("n", "<leader>sC", Snacks.picker.commands, { desc = "Commands" })
map("n", "<leader>sd", Snacks.picker.diagnostics_buffer, { desc = "Buffer Diagnostics" })
map("n", "<leader>sD", Snacks.picker.diagnostics, { desc = "Diagnostics" })
map("n", "<leader>sH", Snacks.picker.highlights, { desc = "Highlights" })
map("n", "<leader>si", Snacks.picker.icons, { desc = "Icons" })
map("n", "<leader>sj", Snacks.picker.jumps, { desc = "Jumps" })
map("n", "<leader>sk", Snacks.picker.keymaps, { desc = "Keymaps" })
map("n", "<leader>sl", Snacks.picker.loclist, { desc = "Location List" })
map("n", "<leader>sm", Snacks.picker.marks, { desc = "Marks" })
map("n", "<leader>sM", Snacks.picker.man, { desc = "Man Pages" })
map("n", "<leader>sp", Snacks.picker.lazy, { desc = "Search for Plugin Spec" })
map("n", "<leader>sq", Snacks.picker.qflist, { desc = "Quickfix List" })
map("n", "<leader>sR", Snacks.picker.resume, { desc = "Resume" })
map("n", "<leader>su", Snacks.picker.undo, { desc = "Undo History" })
map("n", "<leader>uC", Snacks.picker.colorschemes, { desc = "Colorschemes" })

-- LSP
map("n", "gd", Snacks.picker.lsp_definitions, { desc = "Goto Definition" })
map("n", "gD", Snacks.picker.lsp_declarations, { desc = "Goto Declaration" })
map("n", "gr", Snacks.picker.lsp_references, { desc = "References", nowait = true })
map("n", "gI", Snacks.picker.lsp_implementations, { desc = "Goto Implementation" })
map("n", "gy", Snacks.picker.lsp_type_definitions, { desc = "Goto Type Definition" })
map("n", "<leader>ss", Snacks.picker.lsp_symbols, { desc = "LSP Symbols" })
map("n", "<leader>sS", Snacks.picker.lsp_workspace_symbols, { desc = "LSP Workspace Symbols" })

-- Other
map("n", "<leader>z", Snacks.zen, { desc = "Toggle Zen Mode" })
map("n", "<leader>.", Snacks.scratch, { desc = "Toggle Scratch Buffer" })
map("n", "<leader>S", Snacks.scratch.select, { desc = "Select Scratch Buffer" })
map("n", "<leader>bd", Snacks.bufdelete, { desc = "Delete Buffer" })
map("n", "<leader>cR", Snacks.rename.rename_file, { desc = "Rename File" })
map({"n","v"}, "<leader>gB", Snacks.gitbrowse, { desc = "Git Browse" })
map("n", "<leader>gg", Snacks.lazygit, { desc = "Lazygit" })
map("n", "<leader>un", Snacks.notifier.hide, { desc = "Dismiss All Notifications" })
map("n", "<c-_>", Snacks.terminal, { desc = "which_key_ignore" })
map({"n","t"}, "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "Next Reference" })
map({"n","t"}, "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })

-- Open Neovim news in a window
map("n", "<leader>N", function()
  Snacks.win({
    file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
    width = 0.6,
    height = 0.6,
    wo = {
      spell = false,
      wrap = false,
      signcolumn = "yes",
      statuscolumn = " ",
      conceallevel = 3,
    },
  })
end, { desc = "Neovim News" })

-- Optional: setup toggles for very lazy loading
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
    Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
    Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
    Snacks.toggle.diagnostics():map("<leader>ud")
    Snacks.toggle.line_number():map("<leader>ul")
    Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
    Snacks.toggle.treesitter():map("<leader>uT")
    Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
    Snacks.toggle.inlay_hints():map("<leader>uh")
    Snacks.toggle.indent():map("<leader>ug")
    Snacks.toggle.dim():map("<leader>uD")
  end,
})
`
