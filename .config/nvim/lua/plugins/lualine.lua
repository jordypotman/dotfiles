-- NeoVim statusline.
local Plugin = { 'nvim-lualine/lualine.nvim' }

Plugin.event = 'VeryLazy'

Plugin.opts = {
  options = {
    icons_enabled = true,
    section_separators = '',
    component_separators = ''
  }
}

function Plugin.init()
  vim.opt.showmode = false
end

return Plugin
