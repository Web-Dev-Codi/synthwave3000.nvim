local function build(p, o)
  local bg_dark = o.transparent and "NONE" or p.bg_dark
  return {
    TroubleNormal = { fg = p.fg, bg = bg_dark },
    TroubleText = { fg = p.fg },
    TroubleCount = { fg = p.pink, bold = true },
    TroubleNormalFloat = { fg = p.fg, bg = bg_dark },
    TroubleIndent = { fg = p.comment },
    TroubleFoldIcon = { fg = p.comment },
    TroubleLocation = { fg = p.cyan },
    TroubleSource = { fg = p.cyan, bold = true },
    TroubleCode = { fg = p.fg_dim },
  }
end

return { build = build }
