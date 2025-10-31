return {
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      input = { enabled = true },
      picker = { enabled = true },
    }
  }
}
