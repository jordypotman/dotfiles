-- Debug Adapter Protocol client implementation for Neovim
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio', -- required dependency for nvim-dap-ui
    'jay-babu/mason-nvim-dap.nvim'
  },
  config = function()
    require('mason-nvim-dap').setup({
      ensure_installed = {},
      handlers = {}
    })

    local dap, dapui = require('dap'), require('dapui')
    dap.listeners.before['attach']['dapui_config'] = dapui.open
    dap.listeners.before['launch']['dapui_config'] = dapui.open
    dap.listeners.before['event_terminated']['dapui_config'] = dapui.close
    dap.listeners.before['event_exited']['dapui_config'] = dapui.close

    require('user.keymaps').dap.setup()
  end
}
