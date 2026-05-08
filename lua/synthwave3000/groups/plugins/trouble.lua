local function build(p, o)
  return {
    TroubleNormal = { fg = p.fg, bg = p.bg_dark },
    TroubleText = { fg = p.fg },
    TroubleCount = { fg = p.pink, bold = true },
    TroubleNormalFloat = { fg = p.fg, bg = p.bg_dark },
    TroubleIndent = { fg = p.comment },
    TroubleFoldIcon = { fg = p.comment },
    TroubleLocation = { fg = p.cyan },
    TroubleSource = { fg = p.cyan, bold = true },
    TroubleCode = { fg = p.fg_dim },
  }
end

return { build = build }
