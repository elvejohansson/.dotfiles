local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        "tpope/vim-sleuth",

        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            opts = {
                ensure_installed = { "c", "lua", "vimdoc", "json", "yaml" },
                auto_install = true,
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
            },
        },
        {
            "nvim-telescope/telescope.nvim",
            tag = "0.1.8",
            dependencies = {
                "nvim-lua/plenary.nvim",
            },
            config = function()
                local builtin = require("telescope.builtin")
                vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
                vim.keymap.set("n", "<leader>fs", builtin.live_grep, {})
                vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
                vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
            end
        },
        {
            "lukas-reineke/indent-blankline.nvim",
            main = "ibl",
            opts = {
                indent = {
                    char = "▏",
                    smart_indent_cap = true,
                },
                scope = {
                    enabled = true,
                },
            }
        },
        {
            "folke/todo-comments.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim",
            },
            opts = {},
        },
        {
            "lukas-reineke/virt-column.nvim",
            opts = {
                enabled = true,
                char = "┃",
                virtcolumn = "100",
            },
        },
        {
            "f-person/git-blame.nvim",
            opts = {
                enabled = true,
                delay = 175,
            },
        },
        {
            "nvim-lualine/lualine.nvim",
            dependencies = {
                "kyazdani42/nvim-web-devicons",
            },
            opts = {},
        },
        {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            config = true
        }
    },
    checker = { enabled = true },
})
