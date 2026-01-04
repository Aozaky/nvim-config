---@type vim.lsp.Config
return {
	cmd = { "bash-language-server", "start" },
	settings = {
		bashIde = {
			globPattern = "*@(.sh|.inc|.bash|.command|.zsh|.zshrc)",
		},
	},
	filetypes = { "bash", "sh", "zsh" },
	root_markers = { ".git" },
}
