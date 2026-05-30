local plugins = {

  -- 1. Setup our Native LSP Configurations
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  -- 2. Add NERDTree
  {
    "preservim/nerdtree",
    lazy = false, -- Load on startup
    config = function()
      -- Toggle NERDTree with Ctrl + n
      vim.keymap.set("n", "<C-n>", ":NERDTreeToggle<CR>", { silent = true })

      -- Optional: Open NERDTree automatically if Neovim is opened without a file
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if vim.fn.argc() == 0 and vim.fn.line2byte("$") == -1 then
            vim.cmd("NERDTree")
          end
        end,
      })
    end,
  },
}

return plugins
