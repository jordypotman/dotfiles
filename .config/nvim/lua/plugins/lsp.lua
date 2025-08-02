-- Language Server Protocol (LSP) related plugin configuration.
-- Based on: https://github.com/nvim-lua/kickstart.nvim/blob/9929044f2432758bc0a7c3fab13414e49f316443/init.lua
return {
  {
    -- Quickstart configs for Nvim LSP.
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
    },
    cmd = 'LspInfo',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local servers = {
        lua_ls = {
          enabled = vim.fn.executable('lua-language-server') == 1,
          config = {}
        },
        clangd = {
          enabled = vim.fn.executable('clangd') == 1,
          config = {
            capabilities = {
              offsetEncoding = { 'utf-16' },
            }
          }
        },
        tblgen_lsp_server = {
          enabled = vim.fn.executable('tblgen-lsp-server') == 1,
          config = {}
        },
        mlir_lsp_server = {
          enabled = vim.fn.executable('mlir-lsp-server') == 1,
          config = {}
        },
        mlir_pdll_lsp_server = {
          enabled = vim.fn.executable('mlir-pdll-lsp-server') == 1,
          config = {}
        },
        pylsp = {
          enabled = vim.fn.executable('pylsp') == 1,
          config = {}
        },
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      for server_name, _ in pairs(servers) do
        if servers[server_name].enabled then
          local server_config = servers[server_name].config
          server_config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server_config.capabilities or {})
          vim.lsp.config(server_name, server_config)
          vim.lsp.enable(server_name)
        end
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('jordy-lsp-attach', { clear = true }),
        callback = function(event)
          require('user.keymaps').lsp.setup(event.buf)
        end
      })
    end
  },
  {
    -- Faster LuaLS setup for Neovim.
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } }
      }
    }
  }
}
