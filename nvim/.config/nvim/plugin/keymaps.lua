local function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

local function nmap(shortcut, command)
  map("n", shortcut, command)
end

local function imap(shortcut, command)
  map("i", shortcut, command)
end

local function tmap(shortcut, command)
  map("t", shortcut, command)
end

-- jk to escape insert mode
imap("jk", "<esc>")
imap("<esc>", "<nop>")

-- ctrl-hjkl navigates the splits
nmap("<c-h>", "<c-w>h")
nmap("<c-j>", "<c-w>j")
nmap("<c-k>", "<c-w>k")
nmap("<c-l>", "<c-w>l")

-- ctrl-hjkl navigates the splits in terminal mode
tmap("<C-h>", "<C-\\><C-n><C-w>h")
tmap("<C-j>", "<C-\\><C-n><C-w>j")
tmap("<C-k>", "<C-\\><C-n><C-w>k")
tmap("<C-l>", "<C-\\><C-n><C-w>l")
tmap("<Esc>", "<C-\\><C-n>")

-- Quit window on <leader>q
nmap("<leader>q", ":q<CR>")

-- Disable ex mode
nmap("Q", "<nop>")

-- folds keymaps
nmap("<F6>", ":set foldmethod=indent<CR>")
nmap("<F8>", ":setlocal foldnestmax=2<CR>")

-- file explorer
nmap("<leader>pv", ":Ex<CR>")
