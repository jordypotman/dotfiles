local keymaps = {}

keymaps.general = {}

function keymaps.general.setup()
  -- Set mapleader hefore any other mappings because it's value is used at the
  -- moment a mapping is defined.
  vim.g.mapleader = ' '

  -- Show the path of the current file. Useful when the file path in the status
  -- line gets truncated.
  -- From: https://github.com/wincent/wincent/blob/30ea9601ddd061ead644504570546ec0435b77aa/aspects/nvim/files/.config/nvim/plugin/mappings/leader.lua#L13-L15
  vim.keymap.set('n', '<leader>p', ":echo expand('%')<cr>")

  -- Begin LazyVim keymaps
  -- From: https://github.com/LazyVim/LazyVim/blob/acc35382294d91b279b319510b906249a03b2764/lua/lazyvim/config/keymaps.lua

  -- diagnostic
  local diagnostic_goto = function(next, severity)
    return function()
      vim.diagnostic.jump({
        count = (next and 1 or -1) * vim.v.count1,
        severity = severity and vim.diagnostic.severity[severity] or nil,
        float = true,
      })
    end
  end
  vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
  vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
  vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
  vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
  vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
  vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
  vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

  -- End LazyVim keymaps
end

keymaps.dap = {}

function keymaps.dap.get_keys()
  return {
    { '<leader>dc', function() require('dap').continue() end },
    { '<leader>ds', function() require('dap').step_into() end },
    { '<leader>dn', function() require('dap').step_over() end },
    { '<leader>do', function() require('dap').step_out() end },
    { '<leader>db', function() require('dap').toggle_breakpoint() end },
  }
end

keymaps.gitsigns = {}

function keymaps.gitsigns.setup(buffer)
  local gs = package.loaded.gitsigns

  local function map(mode, l, r, desc)
    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
  end

  local function next_change_or_hunk()
    if vim.wo.diff then
      vim.cmd.normal({ ']c', bang = true })
    else
      gs.nav_hunk('next')
    end
  end
  local function prev_change_or_hunk()
    if vim.wo.diff then
      vim.cmd.normal({ '[c', bang = true })
    else
      gs.nav_hunk('prev')
    end
  end
  map('n', ']c', next_change_or_hunk, 'Next Change')
  map('n', '[c', prev_change_or_hunk, 'Prev Change')
  map('n', ']h', next_change_or_hunk, 'Next Hunk')
  map('n', '[h', prev_change_or_hunk, 'Prev Hunk')
  map('n', ']H', function() gs.nav_hunk('last') end, 'Last Hunk')
  map('n', '[H', function() gs.nav_hunk('first') end, 'First Hunk')
  map({ 'n', 'v' }, '<leader>ghs', ':GitSigns stage_hunk<CR>', 'Stage Hunk')
  map({ 'n', 'v' }, '<leader>ghr', ':GitSigns reset_hunk<CR>', 'Reset Hunk')
  map('n', '<leader>ghS', gs.stage_buffer, 'Stage Buffer')
  map('n', '<leader>ghu', gs.undo_stage_hunk, 'Undo Stage Hunk')
  map('n', '<leader>ghR', gs.reset_buffer, "Reset Buffer")
  map('n', '<leader>ghp', gs.preview_hunk_inline, 'Preview Hunk Inline')
  map('n', '<leader>ghb', function() gs.blame_line({ full = true }) end, 'Blame Line')
  map('n', '<leader>ghB', function() gs.blame() end, 'Blame Buffer')
  map('n', '<leader>ghd', gs.diffthis, 'Diff This')
  map('n', '<leader>ghD', function() gs.diffthis('~') end, 'Diff This ~')
  map({ 'o', 'x' }, 'ih', ':<C-U>GitSigns select_hunk<CR>', 'GitSigns Select Hunk')
  map('n', '<leader>gtb', gs.toggle_current_line_blame, 'Toggle Blame Line')
end

keymaps.lsp = {}

function keymaps.lsp.setup(buf)
  local map = function(keys, func, desc, mode)
    mode = mode or 'n'
    vim.keymap.set(mode, keys, func, { buffer = buf, desc = desc })
  end

  -- Common lsp-zero / LazyVim LSP keymaps.
  map('gd', vim.lsp.buf.definition, 'Goto Definition')
  map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
  map('gr', vim.lsp.buf.references, 'References')

  -- lsp-zero LSP keymaps.
  map('gi', vim.lsp.buf.implementation, 'Goto Implementation')
  map('go', vim.lsp.buf.type_definition, 'Goto Type Definition')
  map('gs', vim.lsp.buf.signature_help, 'Signature Help')
  map('<F2>', vim.lsp.buf.rename, 'Rename')
  map('<F3>', vim.lsp.buf.format, 'Format', { 'n', 'x' })
  map('<F4>', vim.lsp.buf.code_action, 'Code Action')
  map('gl', vim.diagnostic.open_float, 'Show Diagnostic')

  -- LazyVim LSP keymaps.
  map('gI', vim.lsp.buf.implementation, 'Goto Implementation')
  map('gy', vim.lsp.buf.type_definition, 'Goto T[y]pe Definition')
  map('gK', vim.lsp.buf.signature_help, 'Signature Help')
  map('<leader>cr', vim.lsp.buf.rename, 'Rename')

  -- Neovim default LSP keymaps.
  map('grn', vim.lsp.buf.rename, 'Rename')
  map('gra', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })
  map('grr', vim.lsp.buf.references, 'References')
  map('gri', vim.lsp.buf.implementation, 'Goto Implementation')
  map('grt', vim.lsp.buf.type_definition, 'Goto Type Definition')
  map('gO', vim.lsp.buf.document_symbol, 'Open Document Symbols')
  map('grd', vim.lsp.buf.definition, 'Goto Definition')
  map('grD', vim.lsp.buf.declaration, 'Goto Declaration')
  map('gW', vim.lsp.buf.workspace_symbol, 'Open Workspace Symbols')
end

keymaps.vim_tmux_navigator = {}

function keymaps.vim_tmux_navigator.get_keys()
  return {
    { '<c-h>',  '<cmd><C-U>TmuxNavigateLeft<cr>' },
    { '<c-j>',  '<cmd><C-U>TmuxNavigateDown<cr>' },
    { '<c-k>',  '<cmd><C-U>TmuxNavigateUp<cr>' },
    { '<c-l>',  '<cmd><C-U>TmuxNavigateRight<cr>' },
    { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
  }
end

keymaps.sidekick = {}

function keymaps.sidekick.get_keys()
  return {
    {
      "<tab>",
      function()
        -- if there is a next edit, jump to it, otherwise apply it if any
        if not require("sidekick").nes_jump_or_apply() then
          return "<Tab>" -- fallback to normal tab
        end
      end,
      expr = true,
      desc = "Goto/Apply Next Edit Suggestion",
    },
    {
      "<c-.>",
      function() require("sidekick.cli").toggle() end,
      desc = "Sidekick Toggle",
      mode = { "n", "t", "i", "x" },
    },
    { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
    {
      "<leader>aa",
      function() require("sidekick.cli").toggle() end,
      desc = "Sidekick Toggle CLI",
    },
    {
      "<leader>as",
      function() require("sidekick.cli").select() end,
      -- Or to select only installed tools:
      -- require("sidekick.cli").select({ filter = { installed = true } })
      desc = "Select CLI",
    },
    {
      "<leader>ad",
      function() require("sidekick.cli").close() end,
      desc = "Detach a CLI Session",
    },
    {
      "<leader>at",
      function() require("sidekick.cli").send({ msg = "{this}" }) end,
      mode = { "x", "n" },
      desc = "Send This",
    },
    {
      "<leader>af",
      function() require("sidekick.cli").send({ msg = "{file}" }) end,
      desc = "Send File",
    },
    {
      "<leader>av",
      function() require("sidekick.cli").send({ msg = "{selection}" }) end,
      mode = { "x" },
      desc = "Send Visual Selection",
    },
    {
      "<leader>ap",
      function() require("sidekick.cli").prompt() end,
      mode = { "n", "x" },
      desc = "Sidekick Select Prompt",
    },
  }
end

keymaps.snacks = {}

function keymaps.snacks.get_keys()
  return {
    -- Top Pickers & Explorer
    { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
    { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
    -- find
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    -- search
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
  }
end

function keymaps.setup()
  keymaps.general.setup()
end

return keymaps
