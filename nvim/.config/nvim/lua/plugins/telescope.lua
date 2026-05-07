return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("telescope").setup {
        extensions = {
          wrap_results = true,
          fzf = {},
        },
      }

      pcall(require("telescope").load_extension, "fzf")

      local builtin = require "telescope.builtin"
      vim.keymap.set("n", "<leader>sf", builtin.find_files)
      vim.keymap.set("n", "<leader>sg", builtin.git_files)
      vim.keymap.set("n", "<leader>sh", builtin.help_tags)
      vim.keymap.set("n", "<leader>sr", builtin.live_grep)
      vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find)
    end,
  },
}
