local opt = vim.opt

opt.inccommand = "split"
opt.number = true
opt.relativenumber = true
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = true
opt.splitright = true
opt.splitbelow = true
opt.signcolumn = "yes"
opt.clipboard = "unnamedplus" -- syncs OS and nvim clipboard
opt.formatoptions:remove "o" --dont have 'o' add a comment line
