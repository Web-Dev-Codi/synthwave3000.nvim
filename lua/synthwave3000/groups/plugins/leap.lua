local function build(p, o)
  return {
    LeapMatch = { fg = p.bg, bg = p.pink, bold = true },
    LeapLabel = { fg = p.pink, bold = true },
    LeapBackdrop = { fg = p.comment },
    LeapLabelPrimary = { fg = p.pink, bold = true },
    LeapLabelSecondary = { fg = p.cyan, bold = true },
  }
end

return { build = build }
