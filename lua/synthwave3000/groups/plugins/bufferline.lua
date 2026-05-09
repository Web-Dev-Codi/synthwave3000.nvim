local function build(p, o)
  local bg = o.transparent and "NONE" or (o.background or p.bg)
  local bg_dark = o.transparent and "NONE" or p.bg_dark
  local bg_darker = o.transparent and "NONE" or p.bg_darker
  return {
    BufferLineFill = { bg = bg_darker },
    BufferLineBackground = { fg = p.fg_dim, bg = bg_dark },
    BufferLineBufferVisible = { fg = p.fg_dim, bg = bg_dark },
    BufferLineBufferSelected = { fg = p.pink, bg = bg, bold = true },
    BufferLineCloseButton = { fg = p.fg_dim, bg = bg_dark },
    BufferLineCloseButtonVisible = { fg = p.fg_dim, bg = bg_dark },
    BufferLineCloseButtonSelected = { fg = p.red, bg = bg },
    BufferLineModified = { fg = p.orange, bg = bg_dark },
    BufferLineModifiedVisible = { fg = p.orange, bg = bg_dark },
    BufferLineModifiedSelected = { fg = p.orange, bg = bg },
    BufferLineIndicatorSelected = { fg = p.pink, bg = bg },
    BufferLineSeparator = { fg = p.bg_highlight, bg = bg_darker },
    BufferLineSeparatorVisible = { fg = p.bg_highlight, bg = bg_dark },
    BufferLineSeparatorSelected = { fg = p.bg, bg = bg },
    BufferLineTab = { fg = p.fg_dim, bg = bg_darker },
    BufferLineTabSelected = { fg = p.pink, bg = bg },
    BufferLineNumbers = { fg = p.fg_dim, bg = bg_dark },
    BufferLineNumbersVisible = { fg = p.fg_dim, bg = bg_dark },
    BufferLineNumbersSelected = { fg = p.pink, bg = bg },
    BufferLineOffsetSeparator = { fg = p.bg_highlight, bg = bg_darker },
  }
end

return { build = build }
