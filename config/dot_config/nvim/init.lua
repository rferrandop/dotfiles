local load = function(mod)
  package.loaded[mod] = nil
  require(mod)
end

load('user.settings')
load('user.commands')
load('user.keymaps')
require('user.plugins')

pcall(vim.cmd.colorscheme, 'tokyonight')

-- Neovide configuration
if vim.g.neovide then
	vim.o.guifont = "MesloLGS NF:h14"

	-- Sets how long the scroll animation takes to complete (in seconds)
	vim.g.neovide_scroll_animation_length = 0.1
	vim.g.neovide_cursor_animation_length = 0.1
end
