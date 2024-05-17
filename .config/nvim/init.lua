-- Set mapleader at top of init.lua because it's value is used at the moment
-- a mapping is defined. This way it also has effect on any leader mappings
-- defined by plugins.
vim.g.mapleader = " "

-- Automatically install lazy.nvim plugin manager for NeoVim.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

vim.opt.number = true
vim.opt.termguicolors = true
