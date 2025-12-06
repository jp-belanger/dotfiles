return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "stevearc/conform.nvim",
    },
    config = function()
      local capabilities = nil
      if pcall(require, "cmp_nvim_lsp") then
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      end

      local servers = { "rust_analyzer", "pyright", "lua_ls", "ts_ls" }

      require("mason").setup()
      local ensure_installed = {
        "stylua",
        "lua_ls",
      }

      vim.list_extend(ensure_installed, servers)
      require("mason-tool-installer").setup { ensure_installed = ensure_installed }

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
          vim.diagnostic.config { virtual_text = false } -- remove in-line virtual-text diagnostics

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
      -- Autoformatting Setup
      require("conform").setup {
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
          rust = { "rustfmt" },
          javascript = { "prettierd", "prettier", stop_after_first = true },
          typescript = { "prettierd", "prettier", stop_after_first = true },
          typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      }
    end,
  },
}
