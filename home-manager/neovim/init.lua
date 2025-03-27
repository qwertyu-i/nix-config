vim.g.mapleader = " "

vim.cmd("set nu rnu")

vim.g.netrw_liststyle = 3

vim.opt.scrolloff = 6

vim.keymap.set( 'n', '<leader>md', ":RenderMarkdown toggle<CR>" )

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		vim.keymap.set( "n", "gra", vim.lsp.buf.code_action )
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
	end
})
