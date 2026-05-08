local function build(p, o)
  return {
    BufferLineFill = { bg = p.bg_darker },
    BufferLineBackground = { fg = p.fg_dim, bg = p.bg_dark },
    BufferLineBufferVisible = { fg = p.fg_dim, bg = p.bg_dark },
    BufferLineBufferSelected = { fg = p.pink, bg = p.bg, bold = true },
    BufferLineCloseButton = { fg = p.fg_dim, bg = p.bg_dark },
    BufferLineCloseButtonVisible = { fg = p.fg_dim, bg = p.bg_dark },
    BufferLineCloseButtonSelected = { fg = p.red, bg = p.bg },
    BufferLineModified = { fg = p.orange, bg = p.bg_dark },
    BufferLineModifiedVisible = { fg = p.orange, bg = p.bg_dark },
    BufferLineModifiedSelected = { fg = p.orange, bg = p.bg },
    BufferLineIndicatorSelected = { fg = p.pink, bg = p.bg },
    BufferLineSeparator = { fg = p.bg_highlight, bg = p.bg_darker },
    BufferLineSeparatorVisible = { fg = p.bg_highlight, bg = p.bg_dark },
    BufferLineSeparatorSelected = { fg = p.bg, bg = p.bg },
    BufferLineTab = { fg = p.fg_dim, bg = p.bg_darker },
    BufferLineTabSelected = { fg = p.pink, bg = p.bg },
    BufferLineNumbers = { fg = p.fg_dim, bg = p.bg_dark },
    BufferLineNumbersVisible = { fg = p.fg_dim, bg = p.bg_dark },
    BufferLineNumbersSelected = { fg = p.pink, bg = p.bg },
    BufferLineOffsetSeparator = { fg = p.bg_highlight, bg = p.bg_darker },
  }
end

return { build = build }
