local M = {}

function M.build(palette, opts)
	local groups = {}

	local function merge(t)
		for name, spec in pairs(t) do
			groups[name] = spec
		end
	end

	merge(require("synthwave3000.groups.editor").build(palette, opts))
	merge(require("synthwave3000.groups.syntax").build(palette, opts))
	merge(require("synthwave3000.groups.treesitter").build(palette, opts))
	merge(require("synthwave3000.groups.lsp").build(palette, opts))

	if opts.plugins.telescope then
		merge(require("synthwave3000.groups.plugins.telescope").build(palette, opts))
	end
	if opts.plugins.nvim_tree then
		merge(require("synthwave3000.groups.plugins.nvim_tree").build(palette, opts))
	end
	if opts.plugins.neo_tree then
		merge(require("synthwave3000.groups.plugins.neo_tree").build(palette, opts))
	end
	if opts.plugins.bufferline then
		merge(require("synthwave3000.groups.plugins.bufferline").build(palette, opts))
	end
	if opts.plugins.gitsigns then
		merge(require("synthwave3000.groups.plugins.gitsigns").build(palette, opts))
	end
	if opts.plugins.diffview then
		merge(require("synthwave3000.groups.plugins.diffview").build(palette, opts))
	end
	if opts.plugins.cmp then
		merge(require("synthwave3000.groups.plugins.nvim_cmp").build(palette, opts))
	end
	if opts.plugins.blink_cmp then
		merge(require("synthwave3000.groups.plugins.blink_cmp").build(palette, opts))
	end
	if opts.plugins.mini then
		merge(require("synthwave3000.groups.plugins.mini").build(palette, opts))
	end
	if opts.plugins.indent_blankline then
		merge(require("synthwave3000.groups.plugins.indent_blankline").build(palette, opts))
	end
	if opts.plugins.which_key then
		merge(require("synthwave3000.groups.plugins.which_key").build(palette, opts))
	end
	if opts.plugins.noice then
		merge(require("synthwave3000.groups.plugins.noice").build(palette, opts))
	end
	if opts.plugins.notify then
		merge(require("synthwave3000.groups.plugins.notify").build(palette, opts))
	end
	if opts.plugins.trouble then
		merge(require("synthwave3000.groups.plugins.trouble").build(palette, opts))
	end
	if opts.plugins.snacks then
		merge(require("synthwave3000.groups.plugins.snacks").build(palette, opts))
	end
	if opts.plugins.dashboard then
		merge(require("synthwave3000.groups.plugins.dashboard").build(palette, opts))
	end
	if opts.plugins.aerial then
		merge(require("synthwave3000.groups.plugins.aerial").build(palette, opts))
	end
	if opts.plugins.dap then
		merge(require("synthwave3000.groups.plugins.dap").build(palette, opts))
	end
	if opts.plugins.neogit then
		merge(require("synthwave3000.groups.plugins.neogit").build(palette, opts))
	end
	if opts.plugins.render_markdown then
		merge(require("synthwave3000.groups.plugins.render-markdown").build(palette, opts))
	end
	return groups
end

return M
