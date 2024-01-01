return {
  'christoomey/vim-tmux-navigator', -- tmux & split window navigation

  -- maximizes and restores current window
  {
    'szw/vim-maximizer',
    keys = {
      { "<leader>sm", ":MaximizerToggle<CR>", desc = "toggle split window maximization" }
    },
  },

  -- vim visual multi edit
  { 'mg979/vim-visual-multi', lazy = false },

  -- essential plugins
  'tpope/vim-surround', -- add, delete, change surroundings (it's awesome)
  'inkarkat/vim-ReplaceWithRegister', -- replace with register contents using motion (gr + motion)

  -- commenting with gc
  'numToStr/Comment.nvim',

  -- vs-code like icons
  'nvim-tree/nvim-web-devicons',

  -- autocompletion
  'hrsh7th/nvim-cmp', -- completion plugin
  'hrsh7th/cmp-buffer', -- source for text in buffer
  'hrsh7th/cmp-path', -- source for file system paths

  -- snippets
  'L3MON4D3/LuaSnip', -- snippet engine
  'saadparwaiz1/cmp_luasnip', -- for autocompletion
  'rafamadriz/friendly-snippets', -- useful snippets

  -- auto closing
  'windwp/nvim-autopairs', -- autoclose parens, brackets, quotes, etc...

  -- git integration
  'lewis6991/gitsigns.nvim', -- show line modifications on left hand side
}