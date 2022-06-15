return function()
    require("nvim-treesitter.configs").setup {
        ensure_installed = {
            "bash", "dockerfile", "fish", "go", "html", "json", "python", "ruby",
            "rust", "svelte", "toml", "tsx", "typescript", "yaml", "zig",
        },
        sync_install = false,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
    }
end
