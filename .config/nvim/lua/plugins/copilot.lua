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
          accept = false, -- handled by nvim-cmp
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
      local cmp = require('cmp')
      local copilot_suggestion = require('copilot.suggestion')

      require('copilot').setup(opts)

      local function set_trigger(trigger)
        vim.b.copilot_suggestion_auto_trigger = trigger
        vim.b.copilot_suggestion_hidden = not trigger
      end

      -- Hide suggestions when the completion menu is open.
      cmp.event:on('menu_opened', function()
        if copilot_suggestion.is_visible() then
          copilot_suggestion.dismiss()
        end
        set_trigger(false)
      end)
      cmp.event:on('menu_closed', function()
        set_trigger(true)
      end)
    end
  },
  -- Turn copilot.lua into a cmp source.
  {
    'zbirenbaum/copilot-cmp',
    opts = {},
  }
}
