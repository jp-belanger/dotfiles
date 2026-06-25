return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("diffview").setup {
      -- Your custom configuration goes here (optional)
    }
  end,
}
