return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    lazy = false,
    priority = 100,
    opts = {
      keymap = { preset = "default" },
      sources = {
        default = { "lsp", "path", "buffer" },
        transform_items = function(_, items)
          return vim.tbl_filter(function(item)
            return item.kind ~= require("blink.cmp.types").CompletionItemKind.Snippet
          end, items)
        end,
      },
      fuzzy = {
        implementation = "prefer_rust_with_warning",
      },
    },
  },
}
