return {
  -- Fully featured & enhanced replacement for copilot.vim complete with API for
  -- interacting with GitHub Copilot.
  -- Partially based on: https://github.com/MariaSolOs/dotfiles/blob/e9eb1f8e027840f872e69e00e082e2be10237499/.config/nvim/lua/plugins/copilot.lua
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'BufReadPost',
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = false, -- handled by blink.cmp
          accept_word = '<M-w>',
          accept_line = '<M-l>',
          next = '<M-]>',
          prev = "<M-[>"
        }
      },
      panel = { enabled = false },
      filetypes = { markdown = true },
      server_opts_overrides = {
        offset_encoding = 'utf-16'
      }
    },
    config = function(_, opts)
      require('copilot').setup(opts)

      local function set_copilot_suggestion(enabled)
        vim.b.copilot_suggestion_auto_trigger = enabled
        vim.b.copilot_suggestion_hidden = not enabled
      end

      -- Hide copilot suggestions when the completion menu is open.
      vim.api.nvim_create_autocmd('User', {
        pattern = 'BlinkCmpMenuOpen',
        callback = function()
          require("copilot.suggestion").dismiss()
          set_copilot_suggestion(false)
        end
      })
      vim.api.nvim_create_autocmd('User', {
        pattern = 'BlinkCmpMenuClose',
        callback = function()
          set_copilot_suggestion(true)
        end
      })
    end
  },
  -- Configurable GitHub Copilot blink.cmp source for Neovim.
  {
    'saghen/blink.cmp',
    optional = true,
    dependencies = { 'fang2hou/blink-copilot' },
    opts = {
      sources = {
        default = { 'copilot' },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },
}
