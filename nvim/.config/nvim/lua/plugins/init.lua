return {
  -- tmux & split window navigation
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

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
  { 'hrsh7th/nvim-cmp', lazy = false }, -- completion plugin
  { 'hrsh7th/cmp-buffer', lazy = false },-- source for text in buffer
  { 'hrsh7th/cmp-path', lazy = false, },-- source for file system paths

  -- snippets
  { 'L3MON4D3/LuaSnip', lazy = false }, -- snippet engine
  { 'saadparwaiz1/cmp_luasnip', lazy = false }, -- for autocompletion
  { 'rafamadriz/friendly-snippets', lazy = false }, -- useful snippets

  -- auto closing
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },

  -- git integration
  'lewis6991/gitsigns.nvim', -- show line modifications on left hand side
  -- neovim greeter dashboard
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<leader>cf', '<cmd>:bd<cr>:Alpha<cr>', desc = 'Close buffer and open alpha dash' }
    },
    config = function ()
      -- require'alpha'.setup(require'alpha.themes.dashboard'.config)
      require'alpha'.setup(require'alpha.themes.startify'.config)
    end
  },
  -- commenting plugin
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    lazy = false,
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    lazy = false,
    config = function()
      require("toggleterm").setup({
        close_on_exit = false,
        autochdir = true,
        shell = vim.o.shell,
        size = 20,
        direction = 'float',
        terminal_mappings = true,
        open_mapping = [[<C-\>]]
      })
    end,
    -- keys = {
    --   { [[<C-\>]], '<cmd>ToggleTerm direction=float<cr>' },
    -- }
  },
  {
    "NeogitOrg/neogit",
    lazy = false,
    keys = {
      { '<leader>gi', '<cmd>Neogit kind=auto<cr>', desc = 'Open neogit in a vertical split' },
    },
    opts = {
      signs = {
        item = { '', '' },
        section = { '', '' }
      }
    },
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  }
}
