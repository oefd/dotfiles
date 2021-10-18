return function()
    require("lualine").setup {
        options = { theme = "nord" },
        sections = {
            lualine_a = {"mode"},
            lualine_b = {"branch"},
            lualine_c = {},
            lualine_x = {"filetype"},
            lualine_y = {"progress"},
            lualine_z = {"location"},
        },
    }
end
