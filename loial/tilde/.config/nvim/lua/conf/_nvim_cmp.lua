return function()
    local cmp = require("cmp")
    vim.opt.completeopt = "menuone,noselect"

    cmp.setup {
        sources = {
            { name = "buffer" },
            { name = "path" },
            { name = "nvim_lsp" },
            { name = "snippy" },
        },
        mapping = {
            ["<c-space>"] = cmp.mapping.complete(),
            ["<c-e>"] = cmp.mapping.close(),
            ["<c-f>"] = cmp.mapping.scroll_docs(4),
            ["<c-d>"] = cmp.mapping.scroll_docs(-4),
            ["<cr>"] = cmp.mapping.confirm({ select = false }),
            ["<tab>"] = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end,
            ["<s-tab>"] = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end,
        },
        snippet = {
            expand = function(args)
                require("snippy").expand_snippet(args.body)
            end,
        },
    }
end
