vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.api.nvim_set_option_value("clipboard", "unnamed", {})

vim.keymap.set("n", "<up>", "<nop>")
vim.keymap.set("n", "<down>", "<nop>")
vim.keymap.set("n", "<left>", "<nop>")
vim.keymap.set("n", "<right>", "<nop>")
vim.keymap.set("i", "<up>", "<nop>")
vim.keymap.set("i", "<down>", "<nop>")
vim.keymap.set("i", "<left>", "<nop>")
vim.keymap.set("i", "<right>", "<nop>")

vim.keymap.set("n", "<leader>fe", vim.cmd.Ex)

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.termguicolors = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.scrolloff = 999

vim.opt.signcolumn = "yes"

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
    checker = {
        enabled = true,
        notify = false,
    },
    spec = {
        "tpope/vim-sleuth",

        {
            "mellow-theme/mellow.nvim",
            lazy = false,
            priority = 1000,
            config = function()
                vim.cmd([[colorscheme mellow]])

                vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
                vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            end
        },
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            opts = {
                ensure_installed = {
                    "c",
                    "lua",
                    "typescript",
                    "php",
                    "json",
                    "yaml",
                    "rust",
                },
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
        },
        {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        },
        {
            -- comp
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            -- snippet engine
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip"
        },
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {},
        },
    },
})

local cmp = require("cmp")

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    window = {},
    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true })
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "vsnip" },
    }, {
        { name = "buffer" },
    })
})

require("mason").setup()

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("mason-lspconfig").setup({
    -- trying to match this as close as possible to treesitter to get a good out-of-the-box setup
    ensure_installed = {
        "clangd",
        "lua_ls",
        "ts_ls",
        "intelephense",
        "jsonls",
        "yamlls",
        "rust_analyzer"
    },
    automatic_installation = true,
    handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup({
                capabilities = capabilities
            })
        end,
    }
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local opts = { buffer = ev.buf }

        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gR", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "gf", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references)
    end
})
