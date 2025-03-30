vim.g.mapleader = " "

vim.cmd("set nu rnu")

vim.g.netrw_liststyle = 3

vim.opt.scrolloff = 6

vim.keymap.set( 'n', '<leader>md', ":RenderMarkdown toggle<CR>" )
