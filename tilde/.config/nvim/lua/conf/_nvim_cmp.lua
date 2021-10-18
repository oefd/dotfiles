return function()
    local cmp = require("cmp")
    vim.opt.completeopt = "menuone,noselect"

    cmp.setup({
        sources = {
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "path" },
            { name = "luasnip" },
        },
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        mapping = {
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<CR>"] = cmp.mapping.confirm({ select = false }),
            ["<C-e>"] = cmp.mapping.close(),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<Tab>"] = function(fallback)
                if cmp.visible() then
                   cmp.select_next_item()
                else
                   fallback()
                end
            end,
            ["<S-Tab>"] = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
               end
            end,
        },
    })
end
