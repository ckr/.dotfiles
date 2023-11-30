local catppuccin_status, catppuccin = pcall(require, "catppuccin")
if not catppuccin_status then
  print("catppuccin not found!") -- print error if catppuccin not installed
  return
end

catppuccin.setup({
    -- latte, frappe, macchiato, mocha
    flavour = "mocha",
})

-- -- setup must be called before loading
-- colorscheme catppuccin = "catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha"
vim.cmd.colorscheme "catppuccin"