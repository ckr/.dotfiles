return {
  -- fuzzy finding w/ telescope

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      -- lua functions that many plugins use
      'nvim-lua/plenary.nvim',
      -- dependency for better sorting performance
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
      },
      'BurntSushi/ripgrep',
      {
        "theprimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
          local setup, harpoon = pcall(require, "harpoon")
          if not setup then
            return
          end
          harpoon.setup({})
        end,
        keys = {
          { "<leader>ha", function() require("harpoon"):list():append() end, desc = "harpoon add file", },
          { "<leader>hr", function() require("harpoon"):list():remove() end, desc = "harpoon remove file", },
          -- { "<leader>hm", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "harpoon quick menu", },
          { "<leader>hn", function() require("harpoon"):list():next() end, desc = "harpoon next", },
          { "<leader>hp", function() require("harpoon"):list():prev() end, desc = "harpoon prev", },
        },
      },
    },
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Lists files in your current working directory, respects .gitignore' },
      { '<leader>fg', '<cmd>Telescope git_files<cr>', desc = 'Fuzzy search through the output of git ls-files command, respects .gitignore' },
      { '<leader>fs', '<cmd>Telescope live_grep<cr>', desc = 'Search for a string in your current working directory and get results live as you type, respects .gitignore. (Requires ripgrep)' },
      { '<leader>fc', '<cmd>Telescope grep_string<cr>', desc = 'Searches for the string under your cursor or selection in your current working directory' },
      { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'list open buffers in current neovim instance' },
      { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'list available help tags' },
      { '<leader>gc', '<cmd>Telescope git_commits<cr>', desc = 'list all git commits (use <cr> to checkout) ["gc" for git commits]' },
      { '<leader>gfc', '<cmd>Telescope git_bcommits<cr>', desc = 'list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]' },
      { '<leader>gb', '<cmd>Telescope git_branches<cr>', desc = 'list git branches (use <cr> to checkout) ["gb" for git branch]' },
      { '<leader>gs', '<cmd>Telescope git_status<cr>', desc = 'list current changes per file with diff preview ["gs" for git status]' },
      { '<leader>hm', '<cmd>Telescope harpoon marks<cr>', desc = 'Harpoon [M]arks' },
    },
    config = function()
      -- import telescope plugin safely
      local telescope_setup, telescope = pcall(require, "telescope")
      if not telescope_setup then
        return
      end

      -- import telescope actions safely
      local actions_setup, actions = pcall(require, "telescope.actions")
      if not actions_setup then
        return
      end

      -- configure telescope
      telescope.setup({
        -- configure custom mappings
        defaults = {
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous, -- move to prev result
              ["<C-j>"] = actions.move_selection_next, -- move to next result
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
            },
          },
        },
        pickers = {
          find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
        },
      })

      telescope.load_extension("fzf")
      telescope.load_extension('harpoon')
    end,
  },
}
