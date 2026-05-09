local function build(p, o)
	return {
		WhichKey = { fg = p.pink, bold = true },
		WhichKeyGroup = { fg = p.cyan, bold = true },
		WhichKeyDesc = { fg = p.fg },
		WhichKeySeparator = { fg = p.pink },
		WhichKeyFloat = { bg = p.bg_dark },
		WhichKeyValue = { fg = p.green },
	}
end

return { build = build }
