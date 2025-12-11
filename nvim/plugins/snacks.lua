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
      { pane = 2, height = 16, section = "terminal", cmd = "fortune", padding = 1 }
    }
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

-- Helper to wrap table-based RHS into a function
local function wrap(f)
  return function() f() end
end

-- Top Pickers & Explorer
map("n", "<leader>,", wrap(Snacks.picker.buffers), { desc = "Buffers" })
map("n", "<leader>:", wrap(Snacks.picker.command_history), { desc = "Command History" })
map("n", "<leader>n", wrap(Snacks.picker.notifications), { desc = "Notification History" })
map("n", "<leader>e", wrap(Snacks.explorer), { desc = "File Explorer" })

-- Find
map("n", "<leader>fb", wrap(Snacks.picker.buffers), { desc = "Buffers" })
map("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find Config File" })
map("n", "<leader>fd", wrap(Snacks.picker.files), { desc = "Find Files" })
map("n", "<leader>fg", wrap(Snacks.picker.git_files), { desc = "Find Git Files" })
map("n", "<leader>fp", wrap(Snacks.picker.projects), { desc = "Projects" })
map("n", "<leader>fr", wrap(Snacks.picker.recent), { desc = "Recent" })
map("n", "<leader>fs", wrap(Snacks.picker.grep), { desc = "Grep" })
map("n", "<leader>fh", wrap(Snacks.picker.help), { desc = "Help Pages" })

-- Git
map("n", "<leader>gb", wrap(Snacks.picker.git_branches), { desc = "Git Branches" })
map("n", "<leader>gl", wrap(Snacks.picker.git_log), { desc = "Git Log" })
map("n", "<leader>gL", wrap(Snacks.picker.git_log_line), { desc = "Git Log Line" })
map("n", "<leader>gs", wrap(Snacks.picker.git_status), { desc = "Git Status" })
map("n", "<leader>gS", wrap(Snacks.picker.git_stash), { desc = "Git Stash" })
map("n", "<leader>gd", wrap(Snacks.picker.git_diff), { desc = "Git Diff (Hunks)" })
map("n", "<leader>gf", wrap(Snacks.picker.git_log_file), { desc = "Git Log File" })

-- Grep/Search
map("n", "<leader>sb", wrap(Snacks.picker.lines), { desc = "Buffer Lines" })
map("n", "<leader>sB", wrap(Snacks.picker.grep_buffers), { desc = "Grep Open Buffers" })
map({"n","x"}, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "Visual selection or word" })
map("n", '<leader>s"', wrap(Snacks.picker.registers), { desc = "Registers" })
map("n", "<leader>s/", wrap(Snacks.picker.search_history), { desc = "Search History" })
map("n", "<leader>sa", wrap(Snacks.picker.autocmds), { desc = "Autocmds" })
map("n", "<leader>sc", wrap(Snacks.picker.command_history), { desc = "Command History" })
map("n", "<leader>sC", wrap(Snacks.picker.commands), { desc = "Commands" })
map("n", "<leader>sd", wrap(Snacks.picker.diagnostics_buffer), { desc = "Buffer Diagnostics" })
map("n", "<leader>sD", wrap(Snacks.picker.diagnostics), { desc = "Diagnostics" })
map("n", "<leader>sH", wrap(Snacks.picker.highlights), { desc = "Highlights" })
map("n", "<leader>si", wrap(Snacks.picker.icons), { desc = "Icons" })
map("n", "<leader>sj", wrap(Snacks.picker.jumps), { desc = "Jumps" })
map("n", "<leader>sk", wrap(Snacks.picker.keymaps), { desc = "Keymaps" })
map("n", "<leader>sl", wrap(Snacks.picker.loclist), { desc = "Location List" })
map("n", "<leader>sm", wrap(Snacks.picker.marks), { desc = "Marks" })
map("n", "<leader>sM", wrap(Snacks.picker.man), { desc = "Man Pages" })
map("n", "<leader>sp", wrap(Snacks.picker.lazy), { desc = "Search for Plugin Spec" })
map("n", "<leader>sq", wrap(Snacks.picker.qflist), { desc = "Quickfix List" })
map("n", "<leader>sR", wrap(Snacks.picker.resume), { desc = "Resume" })
map("n", "<leader>su", wrap(Snacks.picker.undo), { desc = "Undo History" })
map("n", "<leader>uC", wrap(Snacks.picker.colorschemes), { desc = "Colorschemes" })

-- LSP
map("n", "gd", wrap(Snacks.picker.lsp_definitions), { desc = "Goto Definition" })
map("n", "gD", wrap(Snacks.picker.lsp_declarations), { desc = "Goto Declaration" })
map("n", "gr", wrap(Snacks.picker.lsp_references), { desc = "References", nowait = true })
map("n", "gI", wrap(Snacks.picker.lsp_implementations), { desc = "Goto Implementation" })
map("n", "gy", wrap(Snacks.picker.lsp_type_definitions), { desc = "Goto Type Definition" })
map("n", "<leader>ss", wrap(Snacks.picker.lsp_symbols), { desc = "LSP Symbols" })
map("n", "<leader>sS", wrap(Snacks.picker.lsp_workspace_symbols), { desc = "LSP Workspace Symbols" })

-- Other
map("n", "<leader>z", wrap(Snacks.zen), { desc = "Toggle Zen Mode" })
map("n", "<leader>.", wrap(Snacks.scratch), { desc = "Toggle Scratch Buffer" })
map("n", "<leader>S", wrap(Snacks.scratch.select), { desc = "Select Scratch Buffer" })
map("n", "<leader>bd", wrap(Snacks.bufdelete), { desc = "Delete Buffer" })
map("n", "<leader>cR", wrap(Snacks.rename.rename_file), { desc = "Rename File" })
map({"n","v"}, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse" })
map("n", "<leader>gg", wrap(Snacks.lazygit), { desc = "Lazygit" })
map("n", "<leader>un", wrap(Snacks.notifier.hide), { desc = "Dismiss All Notifications" })
map("n", "<c-_>", wrap(Snacks.terminal), { desc = "which_key_ignore" })
map({"n","t"}, "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "Next Reference" })
map({"n","t"}, "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })

-- Neovim News
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

-- Toggle mappings (lazy-loaded)
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
