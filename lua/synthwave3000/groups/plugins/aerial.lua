local function build(p, o)
  local bg = o.transparent and "NONE" or p.bg_dark
  local bg_float = o.transparent and "NONE" or p.bg_dark
  return {
    AerialNormal = { fg = p.fg, bg = bg },
    AerialNormalFloat = { fg = p.fg, bg = bg_float },
    AerialLine = { fg = p.pink, bg = p.bg_highlight, bold = true },
    AerialLineNC = { fg = p.fg, bg = p.bg_highlight },
    AerialGuide = { fg = p.comment },
    AerialPrivate = { fg = p.comment },
    AerialProtected = { fg = p.comment },
  }
end

return { build = build }
