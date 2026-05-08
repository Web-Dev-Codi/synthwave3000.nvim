local function build(p, o)
  return {
    NotifyERRORBorder = { fg = p.red },
    NotifyWARNBorder = { fg = p.yellow },
    NotifyINFOBorder = { fg = p.cyan },
    NotifyDEBUGBorder = { fg = p.comment },
    NotifyTRACEBorder = { fg = p.purple },
    NotifyERRORIcon = { fg = p.red },
    NotifyWARNIcon = { fg = p.yellow },
    NotifyINFOIcon = { fg = p.cyan },
    NotifyDEBUGIcon = { fg = p.comment },
    NotifyTRACEIcon = { fg = p.purple },
    NotifyERRORTitle = { fg = p.red, bold = true },
    NotifyWARNTitle = { fg = p.yellow, bold = true },
    NotifyINFOTitle = { fg = p.cyan, bold = true },
    NotifyDEBUGTitle = { fg = p.comment, bold = true },
    NotifyTRACETitle = { fg = p.purple, bold = true },
    NotifyERRORBody = { fg = p.fg },
    NotifyWARNBody = { fg = p.fg },
    NotifyINFOBody = { fg = p.fg },
    NotifyDEBUGBody = { fg = p.fg },
    NotifyTRACEBody = { fg = p.fg },
  }
end

return { build = build }
