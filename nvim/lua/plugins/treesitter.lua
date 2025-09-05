return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "html",
        "latex",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "rust",
        "typst",
        "vim",
        "vimdoc",
        "yaml"
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}
