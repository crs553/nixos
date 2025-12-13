--- User Commands
vim.api.nvim_create_user_command("CreateMarpSlides", function()
  local buf = vim.api.nvim_buf_get_name(0)

  if buf == "" then
    vim.notify("No file name for current buffer", vim.log.levels.ERROR)
    return
  end

  if not buf:match("%.md$") then
    vim.notify("Current buffer is not a .md file", vim.log.levels.ERROR)
    return
  end

  local pdf = buf:gsub("%.md$", ".pdf")

  -- Save the file first
  vim.cmd("write")

  -- Run Marp
  local cmd = string.format(
    "marp --pdf %q -o %q && xdg-open %q",
    buf,
    pdf,
    pdf
  )

  vim.fn.jobstart(cmd, {
    detach = true,
  })

  vim.notify("Generating Marp slides: " .. pdf)
end, {})

local wk = require("which-key")

wk.add({
  {
    "<leader>p",
    group = "productivity",
  },
  {
    "<leader>pp",
    "<cmd>CreateMarpSlides<CR>",
    desc = "Create Marp PDF slides",
  },
})
