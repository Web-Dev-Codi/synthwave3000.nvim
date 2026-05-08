local function build(p, o)
  return {
    HopNextKey = { fg = p.pink, bold = true },
    HopNextKey1 = { fg = p.cyan, bold = true },
    HopNextKey2 = { fg = p.purple },
    HopUnmatched = { fg = p.comment },
  }
end

return { build = build }
