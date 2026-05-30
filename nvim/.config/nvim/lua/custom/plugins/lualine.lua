return {
  {
    -- statusline
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "catppuccin/nvim",
    },
    config = function()
      local ok, lualine = pcall(require, "lualine")
      if not ok then
        return
      end

      local catppuccin_ok, catppuccin_lualine = pcall(require, "catppuccin.utils.lualine")

      lualine.setup({
        options = {
          icons_enabled = true,
          theme = catppuccin_ok and catppuccin_lualine("mocha") or "auto",
        },
        sections = {
          lualine_c = { "buffers" },
        },
      })
    end,
  },
}
