return function()
    local keymap_opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap(
        "n",
        "<C-p>",
        ":Telescope find_files theme=ivy<CR>",
        keymap_opts
    )
    vim.api.nvim_set_keymap(
        "n",
        "<Leader>fb",
        ":Telescope file_browser theme=ivy<CR>",
        keymap_opts
    )
end
