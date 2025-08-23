return {
  -- Performant, batteries-included completion plugin for Neovim.
  'saghen/blink.cmp',
  version = '1.*',
  event = 'InsertEnter',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    appearance = {
      use_nvim_cmp_as_default = true
    },
    completion = {
      documentation = {
        auto_show = true
      },
      list = {
        selection = {
          preselect = false
        }
      },
      menu = {
        draw = {
          columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind', 'source_name', gap = 1 } },
          components = { source_name = { text = function(ctx) return '[' .. ctx.source_name .. ']' end } }
        }
      }
    },
    keymap = {
      preset = 'enter',
      ['<Tab>' ] = {
        function(cmp)
          local has_words_before = function()
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local line = vim.api.nvim_get_current_line()
            return col ~= 0 and line:sub(col, col):match('%s') == nil
          end
          local copilot_suggestion = require('copilot.suggestion')
          if copilot_suggestion.is_visible() then
            copilot_suggestion.accept()
          elseif cmp.is_visible() then
            if #cmp.get_items() == 1 then
              return cmp.select_and_accept()
            else
              return cmp.select_next()
            end
          elseif has_words_before() then
            cmp.show()
            if #cmp.get_items() == 1 then
              return cmp.select_and_accept()
            end
          end
          return false
        end,
        'fallback'
      },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
      ['<C-y>'] = { 'select_and_accept' },
      ['<C-d>'] = { 'show_documentation', 'hide_documentation', 'fallback' },
      ['<Esc>'] = {
        function(cmp)
          if cmp.get_selected_item_idx() then
            return cmp.cancel()
          end
          return false
        end,
        'fallback'
      },
    },
    sources = {
      default = { 'lsp', 'buffer', 'path', 'snippets' },
      providers = {
        -- Show buffer completions with LSP, defaults to { 'buffer' },
        lsp = { fallbacks = {} }
      }
    }
  },

  opts_extend = {
    'sources.default'
  }
}
