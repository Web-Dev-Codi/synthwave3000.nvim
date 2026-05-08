local function build(p, o)
  return {
    FlashBackdrop = { fg = p.fg_dim },
    FlashMatch = { fg = p.pink, bold = true },
    FlashCurrent = { fg = p.cyan, bold = true },
    FlashLabel = { fg = p.yellow, bold = true },
    FlashPrompt = { fg = p.fg, bg = p.bg_panel },
    FlashPromptIcon = { fg = p.cyan },
    FlashCursor = { fg = p.bg, bg = p.pink },
  }
end

return { build = build }
