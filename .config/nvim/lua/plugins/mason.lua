-- Portable package manger for Neovim. Easily install and manage LSP servers,
-- DAP servers, linters and formatters.
-- Based on: https://lsp-zero.netlify.app/v3.x/guide/lazy-loading-with-lazy-nvim.html
local Plugin = {'williamboman/mason.nvim'}

Plugin.lazy = false

Plugin.config = true

return Plugin
