return function()
    local theme = "ivy"
    local keymap_opts = { noremap = true, silent = true }

    keys = {
        {"<c-p>", "find_files"},
        {"<leader>fd", "find_files"},
        {"<leader>rg", "live_grep"},
    }

    for i,v in ipairs(keys) do
        vim.api.nvim_set_keymap(
            "n",
            v[1],
            ":Telescope "..v[2].." theme="..theme.."<cr>",
            keymap_opts
        )
    end
end
