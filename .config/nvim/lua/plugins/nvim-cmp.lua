-- A completion engine plugin for neovim.
-- Based on: https://lsp-zero.netlify.app/v3.x/guide/lazy-loading-with-lazy-nvim.html
-- Partially based on: https://github.com/MariaSolOs/dotfiles/blob/e9eb1f8e027840f872e69e00e082e2be10237499/.config/nvim/lua/plugins/nvim-cmp.lua
return {
  'hrsh7th/nvim-cmp',
  cond = vim.g.jordy_autocompletion == 'nvim-cmp',
  dependencies = {
    { 'L3MON4D3/LuaSnip' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'zbirenbaum/copilot-cmp' }
  },
  event = 'InsertEnter',
  config = function()
    local lsp_zero = require('lsp-zero')
    lsp_zero.extend_cmp()

    local cmp = require('cmp')
    local cmp_format = lsp_zero.cmp_format({ details = true })
    local cmp_action = lsp_zero.cmp_action()

    cmp.setup({
      sources    = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'copilot' }
      },
      formatting = cmp_format,
      mapping    = cmp.mapping.preset.insert({
        -- Overload tab to accept Copilot suggestions.
        ['<Tab>'] = cmp.mapping(function(fallback)
          local copilot_suggestion = require('copilot.suggestion')
          local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
          end
          if copilot_suggestion.is_visible() then
            copilot_suggestion.accept()
          elseif cmp.visible() then
            if #cmp.get_entries() == 1 then
              cmp.confirm({ select = true })
            else
              cmp.select_next_item()
            end
          elseif has_words_before() then
            cmp.complete()
            if #cmp.get_entries() == 1 then
              cmp.confirm({ select = true })
            end
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
        ['<CR>'] = cmp.mapping.confirm()
      })
    })
  end
}
