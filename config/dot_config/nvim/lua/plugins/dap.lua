local bufmap = function(mode, lhs, rhs)
	local opts = { buffer = true }
	vim.keymap.set(mode, lhs, rhs, opts)
end

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui"
	},
	config = function()
		bufmap('n', "<leader>du", "<cmd>lua require'dapui'.toggle({reset=true})<cr>")
		bufmap('n', "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
		bufmap('n', "<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
	end
}
