return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities {
        textDocument = {
          completion = {
            completionItem = {
              snippetSupport = false,
            },
          },
        },
      }

      local servers = { "rust_analyzer", "ty", "lua_ls", "ts_ls" }

      require("mason").setup()
      require("mason-tool-installer").setup {
        ensure_installed = {
          "stylua",
          "tree-sitter-cli",
          "ruff",
          "prettier",
          "prettierd",
          "rust-analyzer",
          "ty",
          "lua-language-server",
          "typescript-language-server",
        },
      }

      -- Global LSP config (applies to all servers)
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- Enable all configured servers
      vim.lsp.enable(servers)

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

          local builtin = require "telescope.builtin"
          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
          vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
          vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
          vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
          vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, { buffer = 0 })
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = 0 })
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0 })
          vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, { buffer = 0 })

          -- Disable semantic tokens for lua_ls
          if client.name == "lua_ls" then
            client.server_capabilities.semanticTokensProvider = nil
          end

          -- Disable formatting for ts_ls (use prettier via conform instead)
          if client.name == "ts_ls" then
            client.server_capabilities.documentFormattingProvider = false
          end
        end,
      })
    end,
  },
}
