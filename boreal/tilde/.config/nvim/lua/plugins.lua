local fn = vim.fn
local cmd = vim.cmd
local execute = vim.api.nvim_command


-- bootstrap packer if not installed
local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        "git", "clone", "--depth", "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path
    })
end


-- plugins
local packer = require("packer")
packer.startup(function(use)
    use { "wbthomason/packer.nvim" }

    ----------------
    -- aesthetics --
    use { "arcticicestudio/nord-vim" }
    use { "lukas-reineke/indent-blankline.nvim",
        config = require("conf/_indent_blankline") }
    use { "hoob3rt/lualine.nvim",
        requires = { { "kyazdani42/nvim-web-devicons" } },
        config = require("conf/_lualine") }

    -------------
    -- utility --
    use { "editorconfig/editorconfig-vim" }
    use { "tpope/vim-commentary" }
    use { "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/plenary.nvim" } },
        config = require("conf/_telescope") }

    ----------------------
    -- lsp + completion --
    use { "dcampos/nvim-snippy" }

    use { "hrsh7th/nvim-cmp",
        config = require("conf/_nvim_cmp"),
        after = "nvim-snippy" }
    use { "hrsh7th/cmp-path", after = "nvim-cmp" }
    use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }
    use { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }
    use { "dcampos/cmp-snippy", after = "nvim-cmp" }

    use { "neovim/nvim-lspconfig",
        config = require("conf/_nvim_lspconfig"),
        after = "cmp-nvim-lsp" }

    ------------
    -- syntax --
    use { "nvim-treesitter/nvim-treesitter",
        config = require("conf/_nvim_treesitter"),
        run = ":TSUpdate" }
    use { "hashivim/vim-terraform" }

    execute "PackerInstall"
end)
