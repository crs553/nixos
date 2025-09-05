return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,    -- load during startup
  priority = 1000, -- ensure it's loaded before other UI plugins
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = false,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
      },
      integrations = {
        treesitter = true,
        native_lsp = { enabled = true },
      },
      custom_highlights = function(colors)
        return {
          LineNr = { fg = colors.overlay1 },
          CursorLineNr = { fg = colors.pink, style = { "bold" } },
          CursorLine = { bg = colors.surface0 },
        }
      end,
    })
  end,
  init = function()
    -- Set colorscheme early to avoid flicker
    vim.cmd.colorscheme("catppuccin")
  end,
}
