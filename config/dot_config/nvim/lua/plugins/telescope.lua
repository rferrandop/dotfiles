local Plugin = { 'nvim-telescope/telescope.nvim' }

Plugin.branch = '0.1.x'

Plugin.dependencies = {
	{ 'nvim-lua/plenary.nvim' },
	{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
}

Plugin.cmd = { 'Telescope' }

function Plugin.init()
	-- See :help telescope.builtin
	vim.keymap.set('n', '<leader>?', '<cmd>Telescope oldfiles<cr>')
	vim.keymap.set('n', '<leader><space>', '<cmd>Telescope buffers<cr>')
	vim.keymap.set('n', '<C-o>',
		"<cmd>lua require'telescope.builtin'.find_files({ find_command = { 'rg', '--files', '--hidden', '-g', '!.git' }})<cr>")
	vim.keymap.set('n', '<C-g>', '<cmd>Telescope live_grep<cr>')
	vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>')
	vim.keymap.set('n', '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
end

function Plugin.config()
	require('telescope').load_extension('fzf')
end

return Plugin
