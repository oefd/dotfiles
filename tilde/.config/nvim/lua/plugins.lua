local fn = vim.fn
local cmd = vim.cmd

-- bootstrap packer if not installed
local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
      "git", "clone", "--depth", "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
  })
end
local packer = require("packer")

-- auto recompile on editing this file
cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost */.config/nvim/lua/plugins.lua source <afile> | PackerCompile
        autocmd BufWritePost */.config/nvim/lua/conf/_*.lua source <afile> | PackerCompile
    augroup end
]]

packer.startup(function(use)
    use { "wbthomason/packer.nvim" }

    ----------------
    -- aesthetics --
    ----------------
    use { "arcticicestudio/nord-vim" }
    use { "lukas-reineke/indent-blankline.nvim", config = require("conf/_indent_blankline"), }
    use { "hoob3rt/lualine.nvim",
        requires = {"kyazdani42/nvim-web-devicons", opt = true },
        config = require("conf/_lualine"),
    }

    -------------
    -- utility --
    -------------
    use { "editorconfig/editorconfig-vim" }
    use { "tpope/vim-commentary" }
    use { "akinsho/bufferline.nvim",
        requires = {"kyazdani42/nvim-web-devicons", opt = true },
        config = require("conf/_bufferline"),
    }
    use { "nvim-telescope/telescope.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = require("conf/_telescope"),
    }
    use { "kyazdani42/nvim-tree.lua",
        requires = { "kyazdani42/nvim-web-devicons" },
        config = require("conf/_nvim_tree"),
    }

    ------------
    -- syntax --
    ------------
    use { "nvim-treesitter/nvim-treesitter",
        branch = "0.5-compat",
        event = "BufRead",
        config = require("conf/_nvim_treesitter"),
    }
    use { "hashivim/vim-terraform", config = require("conf/_vim_terraform"), }

    ----------------
    -- completion --
    ----------------
    use { "L3MON4D3/LuaSnip" }
    use { "saadparwaiz1/cmp_luasnip" }

    use { "hrsh7th/nvim-cmp", config = require("conf/_nvim_cmp"), }
    use { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp", }
    use { "hrsh7th/cmp-buffer", after = "nvim-cmp", }
    use { "hrsh7th/cmp-path", after = "nvim-cmp", }
    use { "neovim/nvim-lspconfig",
        config = require("conf/_nvim_lspconfig"),
        after = "cmp-nvim-lsp",
    }

    if packer_bootstrap then
        packer.sync()
    end
end)
