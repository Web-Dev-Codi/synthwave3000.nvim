local function build(p, o)
  local util = require("synthwave3000.util")
  local bg = o.transparent and "NONE" or (o.background or p.bg)

  -- Ensure ghost text is readable: target >= 5.0 contrast where possible
  local function high_contrast_ghost(base, background)
    if background == "NONE" then
      -- Can't compute contrast against unknown background; fallback to a dim fg
      return p.fg_dim
    end
    local target = 5.0
    local fg = base
    local tries = 0
    local adjust = (o.style == "light") and util.darken or util.brighten
    while util.contrast(fg, background) < target and tries < 12 do
      fg = adjust(fg, 0.06) -- step lightness by ~6%
      tries = tries + 1
    end
    return fg
  end

  return {
    -- Inline ghost text suggestion from Copilot
    CopilotSuggestion = { fg = high_contrast_ghost(p.comment, bg) },
    -- Small status annotation like (1/3) when cycling suggestions
    CopilotAnnotation = { fg = p.green },
  }
end

return { build = build }
