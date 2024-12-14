local group = vim.api.nvim_create_augroup('user_cmds', { clear = true })

vim.api.nvim_create_user_command('ReloadConfig', 'source ~/.config/nvim/init.lua', {})

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight on yank',
	group = group,
	callback = function()
		vim.highlight.on_yank({ higroup = 'Visual', timeout = 300 })
	end,
})

-- Format file on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})

-- Set sh filetypes for chezmoi sh templates
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.sh.tmpl",
	callback = function()
		vim.bo.filetype = "sh"
	end
})
