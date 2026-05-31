vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

-- Create an autocmd group for diagnostic hovers
local diagnostic_hover_grp = vim.api.nvim_create_augroup("DiagnosticHover", { clear = true })

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = diagnostic_hover_grp,
  callback = function()
    vim.diagnostic.open_float(nil, {
      scope = "cursor", -- "cursor" is usually preferred over "buffer" for automated hovers
      focusable = false,
      close_events = { "CursorMoved", "CursorMovedI", "BufLeave" },
    })
  end,
})

vim.opt.updatetime = 500 -- time in milliseconds

vim.schedule(function()
  require "mappings"
end)
