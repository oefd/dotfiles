return function()
    require("nvim-tree").setup()

    local keymap_opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap(
        "n",
        "<Leader>tr",
        ":NvimTreeToggle<CR>",
        keymap_opts
    )
end
