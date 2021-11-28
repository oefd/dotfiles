-- ex: et sw=4 ts=4
local api = vim.api
local cmd = vim.cmd
local opt = vim.opt
local g = vim.g

require("plugins")


-------------
-- general --
g.mapleader = ";"

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


--------------
-- keybinds --
local keymap_opts = { noremap = true, silent = true }
api.nvim_set_keymap("n", "<c-n>", ":bnext<cr>", keymap_opts)
api.nvim_set_keymap("n", "<c-l>", ":nohl<cr>", keymap_opts)
api.nvim_set_keymap("n", "<leader>bd", ":b#<bar>bd#<cr>", keymap_opts)


----------------
-- aesthetics --
opt.termguicolors = true
cmd [[
    try
        colorscheme nord
    catch /^Vim\%((\a\+)\)\=:E185/
        " ignore not-yet-installed colorscheme
    endtry
]]
