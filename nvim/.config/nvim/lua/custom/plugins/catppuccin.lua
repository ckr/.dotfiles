return {
  {
    -- preferred colorscheme
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        -- latte, frappe, macchiato, mocha
        flavour = "mocha",
        integrations = {
          cmp = true,
          gitsigns = true,
          dashboard = true,
          harpoon = true,
          illuminate = true,
          indent_blankline = {
            enabled = false,
            scope_color = "sapphire",
            colored_indent_levels = false,
          },
          mason = true,
          native_lsp = { enabled = true },
          notify = true,
          neotree = true,
          noice = false,
          symbols_outline = true,
          telescope = true,
          treesitter = true,
          treesitter_context = true,
        },
      })
    end,
    init = function()
      vim.cmd.colorscheme("catppuccin")
      vim.cmd("hi DashboardFooter guifg=bg guibg=fg")
    end,
  },
}
