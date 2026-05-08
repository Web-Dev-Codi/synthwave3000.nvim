local function build(p, o)
  return {
    DapStoppedLine = { bg = p.bg_highlight },
    DapBreakpoint = { fg = p.red },
    DapBreakpointCondition = { fg = p.orange },
    DapBreakpointRejected = { fg = p.red },
    DapLogPoint = { fg = p.cyan },
    DapStopped = { fg = p.green },
    DapUIBreakpointsPath = { fg = p.cyan },
    DapUIBreakpointsInfo = { fg = p.cyan },
    DapUIBreakpointsCurrentLine = { fg = p.yellow, bold = true },
    DapUIScope = { fg = p.pink, bold = true },
    DapUIType = { fg = p.cyan },
    DapUIValue = { fg = p.fg },
    DapUIVariable = { fg = p.fg },
    DapUIDecoration = { fg = p.comment },
    DapUIThread = { fg = p.pink },
    DapUIStoppedThread = { fg = p.green, bold = true },
    DapUIFrameName = { fg = p.fg },
    DapUISource = { fg = p.cyan },
    DapUILineNumber = { fg = p.comment },
    DapUIFloatBorder = { fg = p.pink },
    DapUIWatchesEmpty = { fg = p.red },
    DapUIWatchesValue = { fg = p.green },
    DapUIWatchesError = { fg = p.red },
    DapUIModifiedValue = { fg = p.orange },
    DapUIUnavailable = { fg = p.comment },
  }
end

return { build = build }
