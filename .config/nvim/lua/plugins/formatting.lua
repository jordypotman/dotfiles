return {
  -- mini.trailspace
  -- Neovim Lua plugin to manage trailspace (highlight and remove). Part of
  -- 'mini.nvim' library.
  -- https://github.com/nvim-mini/mini.trailspace
  {
    'nvim-mini/mini.trailspace',
    event = 'VeryLazy',
    opts = {},
    config = function(_, opts)
      require('mini.trailspace').setup(opts)

      -- The MiniTrailspace highlight group by default links to the Error
      -- highlight group which has red as the foreground color and black as the
      -- background color, resulting in an invisble highlight for whitespace
      -- characters. So swap the foreground and background colors.
      local hl = vim.api.nvim_get_hl(0, { name = 'MiniTrailspace' })
      while hl['link'] ~= nil do
        hl = vim.api.nvim_get_hl(0, { name = hl['link'] })
      end
      vim.api.nvim_set_hl(0, 'MiniTrailspace', { fg = hl['bg'], bg = hl['fg'] })

      vim.api.nvim_create_user_command('TrailspaceHighlight',
        function()
          MiniTrailspace.highlight()
        end, {})

      vim.api.nvim_create_user_command('TrailspaceUnhighlight',
        function()
          MiniTrailspace.unhighlight()
        end, {})

      vim.api.nvim_create_user_command('TrailspaceTrimLine',
        function(args)
          if args.range == 0 then
            vim.cmd([[keeppatterns s/\s\+$//e]])
          else
            vim.cmd([[keeppatterns '<,'>s/\s\+$//e]])
          end
        end, { range = true })

      vim.api.nvim_create_user_command('TrailspaceTrimFile',
        function()
          MiniTrailspace.trim()
        end, {})

      vim.api.nvim_create_user_command('TrailspaceTrimLastLines',
        function()
          MiniTrailspace.trim_last_lines()
        end, {})
    end
  }
}
