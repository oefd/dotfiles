return function()
    local nvim_lsp = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

    local servers = { "rust_analyzer", "gopls", "tsserver", "pylsp" }

    local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true }
        -- `:help vim.lsp.* for docs
        local keys = {
            { "gd", "<cmd>lua vim.lsp.buf.definition()<cr>" },
            { "K", "<cmd>lua vim.lsp.buf.hover()<cr>" },
            { "gt", "<cmd>lua vim.lsp.buf.type_definition()<cr>" },
            { "gr", "<cmd>lua vim.lsp.buf.references()<cr>" },
            { "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>" },
            { "<leader>fm", "<cmd>lua vim.lsp.buf.formatting()<cr>" },
            { "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>" },
            { "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>" },
        }

        for _, v in ipairs(keys) do
            vim.api.nvim_buf_set_keymap(bufnr, "n", v[1], v[2], opts)
        end
    end

    for _, lsp in ipairs(servers) do
        nvim_lsp[lsp].setup {
            on_attach = on_attach,
            flags = { debounce_text_changes = 150 },
            capabilities = capabilities,
        }
    end
end
