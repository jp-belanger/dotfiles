return {
    -- lsp
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },

    -- completion
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-nvim-lua" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "saadparwaiz1/cmp_luasnip", dependencies = { "L3MON4D3/LuaSnip" } },
    { "tamago324/cmp-zsh" },

    -- treesitter
    { "nvim-treesitter/nvim-treesitter" },

    -- telescope
    {"nvim-telescope/telescope.nvim", branch = '0.1.x', dependencies = { "nvim-lua/plenary.nvim" } },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

    -- misc
    { "tpope/vim-fugitive" },
    { "tpope/vim-surround" },
    { "numToStr/Comment.nvim" },
    { "hkupty/iron.nvim" },
    { "lewis6991/gitsigns.nvim" },
    { "nvim-lualine/lualine.nvim" },
    { "tjdevries/colorbuddy.nvim", lazy = false },
    { "norcalli/nvim-colorizer.lua" },
    { "onsails/lspkind-nvim" },
    { "rust-lang/rust.vim", ft = "rust" },
    { "cespare/vim-toml", ft = "toml" },
    { "stephpy/vim-yaml", ft = "yaml" },
    { "tomlion/vim-solidity", ft = "solidity" },
}
