local api = vim.api
local cmd = vim.cmd
local opt = vim.opt
local g = vim.g

require("plugins")

----------------------
-- general settings --
----------------------
g.mapleader = ";"
g.maplocalleader = ","

opt.number = true
opt.hidden = true
opt.modeline = true
opt.showmode = false
opt.signcolumn = "yes"
opt.mouse = "a"
opt.clipboard = "unnamedplus"

opt.backup = false
opt.swapfile = false
opt.writebackup = false

----------------
-- aesthetics --
----------------
opt.termguicolors = true
cmd [[
    try
        colorscheme nord
    catch /^Vim\%((\a\+)\)\=:E185/
        " do nothing if colorscheme isn't installed yet
    endtry
]]

--------------
-- terminal --
--------------
cmd [[
    command Term :belowright split term://$SHELL
    autocmd TermOpen * setlocal listchars= nonumber norelativenumber nocursorline
    autocmd TermOpen * startinsert
    autocmd TermClose * :q!
    autocmd BufLeave term://* stopinsert
]]

-----------------
-- keybindings --
-----------------
local keymap_opts = { noremap = true, silent = true }
api.nvim_set_keymap("n", "<C-n>", ":bnext<CR>", keymap_opts)
api.nvim_set_keymap("n", "<C-l>", ":nohl<CR>", keymap_opts)
api.nvim_set_keymap("n", "<Leader>bc", ":b#<bar>bd#<CR>", keymap_opts)
api.nvim_set_keymap("n", "<Leader>te", ":Term<CR>", keymap_opts)
