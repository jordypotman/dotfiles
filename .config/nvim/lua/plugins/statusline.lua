-- NeoVim statusline.
return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',

  opts = function()
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

    local lsp_status = {
      'lsp_status',
      ignore_lsp = { 'copilot' },
    }

    local copilot_status = {
      function()
        return " "
      end,
      color = function()
        local status = require("sidekick.status").get()
        if status then
          return status.kind == "Error" and "DiagnosticError" or status.busy and "DiagnosticWarn" or "Special"
        end
      end,
      cond = function()
        local status = require("sidekick.status")
        return status.get() ~= nil
      end,
    }

    local sections = vim.deepcopy(common_sections)
    sections.lualine_b = { 'branch', lsp_status, copilot_status, 'diff', 'diagnostics' }

    local inactive_sections = common_sections

    return {
      options = {
        icons_enabled = true,
        section_separators = '',
        component_separators = ''
      },
      sections = sections,
      inactive_sections = inactive_sections
    }
  end,

  init = function()
    vim.opt.showmode = false
  end
}
