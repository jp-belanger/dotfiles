local function map(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, { silent = true })
end

-- jk to escape insert mode
map("i", "jk", "<esc>")
map("i", "<esc>", "<nop>")

-- ctrl-hjkl navigates the splits
map("n", "<c-h>", "<c-w>h")
map("n", "<c-j>", "<c-w>j")
map("n", "<c-k>", "<c-w>k")
map("n", "<c-l>", "<c-w>l")

-- ctrl-hjkl navigates the splits in terminal mode
map("t", "<C-h>", "<C-\\><C-n><C-w>h")
map("t", "<C-j>", "<C-\\><C-n><C-w>j")
map("t", "<C-k>", "<C-\\><C-n><C-w>k")
map("t", "<C-l>", "<C-\\><C-n><C-w>l")
map("t", "<Esc>", "<C-\\><C-n>")

-- Quit window on <leader>q
map("n", "<leader>q", ":q<CR>")

-- Disable ex mode
map("n", "Q", "<nop>")

-- folds keymaps
map("n", "<F6>", ":set foldmethod=indent<CR>")
map("n", "<F8>", ":setlocal foldnestmax=2<CR>")
