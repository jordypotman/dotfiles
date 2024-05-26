-- NeoVim statusline.
local Plugin = { 'nvim-lualine/lualine.nvim' }

Plugin.event = 'VeryLazy'

local function encoding_fileformat()
  return vim.opt.fileencoding:get() .. '[' .. vim.bo.fileformat .. ']'
end

local function location()
  local line = vim.fn.line('.')
  local num_lines = tostring(vim.fn.line('$'))
  local len_num_lines = tostring(string.len(num_lines))
  local col = vim.fn.virtcol('.')
  return string.format('%' .. len_num_lines .. 'd/%s:%-2d', line, num_lines, col)
end

local common_sections = {
  lualine_c = { { 'filename', path = 1 } },
  lualine_x = { 'filetype' },
  lualine_y = { encoding_fileformat },
  lualine_z = { '%3p%%', location }
}

Plugin.opts = {
  options = {
    icons_enabled = true,
    section_separators = '',
    component_separators = ''
  },
  sections = common_sections,
  inactive_sections = common_sections,
}

function Plugin.init()
  vim.opt.showmode = false
end

return Plugin
