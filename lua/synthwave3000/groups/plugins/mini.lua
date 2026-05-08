local function build(p, o)
  return {
    MiniIndentscopeSymbol = { fg = p.comment },
    MiniStatuslineModeNormal = { fg = p.bg, bg = p.pink, bold = true },
    MiniStatuslineModeInsert = { fg = p.bg, bg = p.cyan, bold = true },
    MiniStatuslineModeVisual = { fg = p.bg, bg = p.purple, bold = true },
    MiniStatuslineModeReplace = { fg = p.bg, bg = p.orange, bold = true },
    MiniStatuslineModeCommand = { fg = p.bg, bg = p.yellow, bold = true },
    MiniStatuslineModeOther = { fg = p.bg, bg = p.comment, bold = true },
    MiniStatuslineDevinfo = { fg = p.fg_dim, bg = p.bg_dark },
    MiniStatuslineFilename = { fg = p.fg, bg = p.bg_dark },
    MiniStatuslineFileinfo = { fg = p.fg_dim, bg = p.bg_dark },
    MiniStatuslineInactive = { fg = p.fg_dim, bg = p.bg_darker },
    MiniTablineCurrent = { fg = p.pink, bg = p.bg, bold = true },
    MiniTablineVisible = { fg = p.fg, bg = p.bg_dark },
    MiniTablineHidden = { fg = p.fg_dim, bg = p.bg_darker },
    MiniTablineModifiedCurrent = { fg = p.orange, bg = p.bg },
    MiniTablineModifiedVisible = { fg = p.orange, bg = p.bg_dark },
    MiniTablineModifiedHidden = { fg = p.orange, bg = p.bg_darker },
    MiniTablineFill = { bg = p.bg_darker },
    MiniCursorword = { underline = true },
    MiniCursorwordCurrent = { underline = true },
    MiniHipatternsTodo = { fg = p.yellow, bg = p.bg_highlight, bold = true },
    MiniHipatternsNote = { fg = p.cyan, bg = p.bg_highlight },
    MiniHipatternsFixme = { fg = p.orange, bg = p.bg_highlight, bold = true },
    MiniHipatternsHack = { fg = p.purple, bg = p.bg_highlight },
    MiniPickPrompt = { fg = p.cyan },
    MiniPickMatchCurrent = { fg = p.fg, bg = p.bg_highlight },
    MiniPickMatchMarked = { fg = p.pink, bold = true },
    MiniPickMatchRanges = { fg = p.cyan, bold = true },
  }
end

return { build = build }
