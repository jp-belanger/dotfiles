local api = vim.api

-- Insert more when entering a terminal buffer
local InsertOnTerminalGrp = api.nvim_create_augroup("InsertOnTerminal", { clear = true })
api.nvim_create_autocmd("BufEnter", {
  command = "if &buftype == 'terminal' | startinsert | endif",
  group = InsertOnTerminalGrp,
})

api.nvim_create_autocmd("TermOpen", { command = "setlocal nonumber norelativenumber" })
