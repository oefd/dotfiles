return function()
    require("lualine").setup {
        options = {
            theme = "nord",
            component_separators = { left = "|", right = "|" },
            section_separators = { left = "", right = "" },
        },
    }
end
