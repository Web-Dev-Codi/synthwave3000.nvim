local M = {}

M.defaults = {
	style = "auto",
	transparent = false,
	background = nil,
	terminal_colors = true,
	styles = {
		comments = { italic = true },
		keywords = { bold = true },
		functions = { bold = true },
		variables = {},
		strings = {},
		types = { bold = true },
		operators = {},
	},
	on_colors = nil,
	on_highlights = nil,
	plugins = {
		telescope = true,
		nvim_tree = true,
		neo_tree = true,
		bufferline = true,
		gitsigns = true,
		diffview = true,
		copilot = true,
		cmp = true,
		blink_cmp = true,
		mini = true,
		indent_blankline = true,
		which_key = true,
		noice = true,
		notify = true,
		trouble = true,
		flash = true,
		snacks = true,
		dashboard = true,
		aerial = true,
		dap = true,
		neogit = true,
		render_markdown = true,
	},
}

function M.extend(opts)
	opts = opts or {}
	local config = vim.deepcopy(M.defaults)
	config = vim.tbl_deep_extend("force", config, opts)
	if config.style == "auto" then
		config.style = vim.o.background == "light" and "light" or "dark"
	end
	return config
end

return M
