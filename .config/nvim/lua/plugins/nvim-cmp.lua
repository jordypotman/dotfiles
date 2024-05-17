local Plugin = {'hrsh7th/nvim-cmp'}

Plugin.dependencies = {
  {'L3MON4D3/LuaSnip'},
  {'hrsh7th/cmp-buffer'}
}

Plugin.event = 'InsertEnter'

Plugin.config = function()
  local lsp_zero = require('lsp-zero')
  lsp_zero.extend_cmp()

  local cmp = require('cmp')
  local cam_format = lsp_zero.cmp_format({details = true})
  local cmp_action = lsp_zero.cmp_action()

  cmp.setup({
    sources  = {
      {name = 'nvim_lsp'},
      {name = 'buffer'}
    },
    formatting = cmp_format,
    mapping = cmp.mapping.preset.insert({
      ['<Tab>'] = cmp_action.tab_complete(),
      ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
      ['<CR>'] = cmp.mapping.confirm({select = true})
    })
  })
end

return Plugin
