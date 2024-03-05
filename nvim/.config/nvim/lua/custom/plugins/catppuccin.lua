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
      })
    end,
    init = function()
      vim.cmd.colorscheme("catppuccin")
      vim.cmd("hi DashboardFooter guifg=bg guibg=fg")
    end,
  },
}
