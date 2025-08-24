-- Setup lazy.nvim plugin manager.
-- https://github.com/folke/lazy.nvim
local lazy = {}

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

lazy.opts = {
  install = {
    missing = false,
  },
  change_detection = {
    enabled = false, -- check for config file changes
    notify = false,  -- get a notification when changes are found
  }
}

function lazy.install(path)
  if not (vim.uv or vim.loop).fs_stat(path) then
    print('Installing lazy.nvim...')
    local repo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none',
      '--branch=stable', repo, path })
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
    print('Done.')
  end
end

function lazy.setup(plugins)
  -- The line below can be commented out after lazy.nvim is installed.
  -- lazy.install(lazy.path)

  vim.opt.rtp:prepend(lazy.path)

  require('lazy').setup(plugins, lazy.opts)
end

local plugin_manager = {}

function plugin_manager.setup()
  lazy.setup({{import = 'plugins'}, {import = 'local/plugins'}})
end

return plugin_manager
