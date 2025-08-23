-- Jordy Potman's Neovim config.
-- Based on: https://github.com/VonHeikemen/lazy-template

local load = function(mod)
  package.loaded[mod] = nil -- Allow reloading a required lua module.
  return require(mod)
end

-- Load keymaps before other files because it sets mapleader.
-- This way it also has effect on any leader mappings defined by plugins.
load('config.keymaps').setup()
load('config.options').setup()
load('config.commands').setup()
require('config.plugins').setup()
