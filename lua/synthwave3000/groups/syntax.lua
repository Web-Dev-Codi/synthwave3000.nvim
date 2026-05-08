local function build(p, o)
  local util = require("synthwave3000.util")
  local glow_enabled = o.glow.enabled and o.style == "dark"

  local function maybe_glow(fg)
    if glow_enabled then
      return { fg = util.brighten(fg, o.glow.brighten), bold = o.glow.bold }
    end
    return { fg = fg }
  end

  return {
    Comment = { fg = p.comment, italic = o.styles.comments.italic ~= false },
    Constant = { fg = p.orange },
    String = { fg = p.orange_bright },
    Character = { fg = p.orange },
    Number = { fg = p.orange },
    Boolean = { fg = p.orange },
    Float = { fg = p.orange },
    Identifier = { fg = p.pink },
    Function = maybe_glow(p.cyan),
    Statement = { fg = p.yellow },
    Conditional = maybe_glow(p.yellow),
    Repeat = maybe_glow(p.yellow),
    Label = { fg = p.pink },
    Operator = { fg = p.yellow },
    Keyword = maybe_glow(p.yellow),
    Exception = maybe_glow(p.red),
    PreProc = { fg = p.purple },
    Include = { fg = p.green },
    Define = { fg = p.yellow },
    Macro = { fg = p.yellow },
    PreCondit = { fg = p.purple },
    Type = maybe_glow(p.red),
    StorageClass = maybe_glow(p.red),
    Structure = maybe_glow(p.red),
    Typedef = maybe_glow(p.red),
    Special = { fg = p.pink },
    SpecialChar = { fg = p.orange },
    Tag = { fg = p.green },
    Delimiter = { fg = p.fg_dim },
    SpecialComment = { fg = p.comment, italic = true },
    Debug = { fg = p.orange },
    Underlined = { underline = true },
    Ignore = { fg = p.fg_dim },
    Error = { fg = p.red, bold = true },
    Todo = { fg = p.yellow, bg = util.blend(p.yellow, p.bg, 0.15), bold = true },
  }
end

return { build = build }
