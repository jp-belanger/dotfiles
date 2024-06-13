return {
  {
    "hkupty/iron.nvim",
    config = function()
      local iron = require "iron.core"
      iron.setup {
        config = {
          close_window_on_exit = true,
          repl_open_cmd = "botright vertical split",
          repl_definition = {
            python = require("iron.fts.python").ipython,
          },
        },
        keymaps = {
          visual_send = "<space>sc",
        },
      }
      vim.keymap.set("n", "<leader>$", ":IronRepl<CR>", { noremap = true, silent = true })
    end,
  },
}
