vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd.colorscheme("quiet")

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

vim.api.nvim_set_option("clipboard", "unnamed")

require("elve.keymaps")
require("elve.lazy")
require("elve.options")
