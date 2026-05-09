local function build(p, o)
	return {
		WhichKey = { fg = p.pink, bold = true },
		WhichKeyGroup = { fg = p.cyan, bold = true },
		WhichKeyDesc = { fg = p.fg },
		WhichKeySeparator = { fg = p.fg_dim },
		WhichKeyFloat = { bg = p.none },
		WhichKeyBorder = { fg = p.green, bg = p.bg_panel },
		WhichKeyValue = { fg = p.green },
	}
end

return { build = build }
