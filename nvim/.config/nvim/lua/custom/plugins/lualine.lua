return {
  {
    -- statusline
    "nvim-lualine/lualine.nvim",
    config = function()
      -- import lualine plugin safely
      local status, lualine = pcall(require, "lualine")
      if not status then
        return
      end

      -- configure lualine with modified theme
      lualine.setup({
        options = {
          theme = "catppuccin",
        },
      })
    end,
  },
}
