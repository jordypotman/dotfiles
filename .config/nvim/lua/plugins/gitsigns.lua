-- Git decorations.
local Plugin = {'lewis6991/gitsigns.nvim'}

Plugin.event = {'BufReadPre', 'BufNewFile'}

function Plugin.config()
  require('gitsigns').setup {
    on_attach = function(bufnr)
      require('user.keymaps').gitsigns.setup(bufnr)
    end
  }
end

return Plugin
