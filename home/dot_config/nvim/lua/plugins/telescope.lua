return {
  "nvim-telescope/telescope.nvim",
  keys = function()
    return {
      {
        "<C-o>",
        function()
          local telescope = require("telescope.builtin")

          local lsp_filetype = {
            jdtls = "*.java",
            lua_ls = "*.lua",
          }

          -- Check active LSP clients in the current buffer
          local active_lsp_ext = nil
          for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
            if lsp_filetype[client.name] then
              active_lsp_ext = lsp_filetype[client.name]
              break -- Stop at the first match
            end
          end

          local is_git_repo = vim.fn.system("git rev-parse --is-inside-work-tree") == "true\n"

          local find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" } -- Exclude .git directory

          -- If an LSP is active, use the associated extension filter with ripgrep
          if active_lsp_ext then
            table.insert(find_command, "--glob")
            table.insert(find_command, active_lsp_ext)
          end

          local opts = {}
          if is_git_repo and not active_lsp_ext then
            telescope.git_files()
          else
            opts.find_command = find_command
            telescope.find_files(opts)
          end
        end,
        desc = "Find Files (git)",
      },
    }
  end,
}
