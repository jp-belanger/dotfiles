return {
  {
    "hkupty/iron.nvim",
    config = function()
      local iron = require "iron.core"
      iron.setup {
        config = {
          close_window_on_exit = true,
          repl_open_cmd = "botright vertical split",
          ignore_blank_lines = true,
          repl_definition = {
            python = {
              command = { "ipython", "--no-autoindent" },
              require("iron.fts.common").bracketed_paste_python,
            },
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
