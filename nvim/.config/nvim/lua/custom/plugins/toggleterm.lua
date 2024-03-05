return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    lazy = false,
    config = function()
      require("toggleterm").setup({
        close_on_exit = false,
        autochdir = true,
        shell = vim.o.shell,
        size = 20,
        direction = "float",
        terminal_mappings = true,
        open_mapping = [[<C-\>]],
      })
    end,
    -- keys = {
    --   { [[<C-\>]], '<cmd>ToggleTerm direction=float<cr>' },
    -- }
  },
}
