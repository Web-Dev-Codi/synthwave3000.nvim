local function build(p, o)
  return {
    IblIndent = { fg = p.bg_highlight },
    IblWhitespace = { fg = p.bg_highlight },
    IblScope = { fg = p.comment },
  }
end

return { build = build }
