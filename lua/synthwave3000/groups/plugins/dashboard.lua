local function build(p, o)
  return {
    DashboardHeader = { fg = p.pink, bold = true },
    DashboardFooter = { fg = p.comment, italic = true },
    DashboardKey = { fg = p.cyan, bold = true },
    DashboardDesc = { fg = p.fg_dim },
    DashboardIcon = { fg = p.pink },
    DashboardShortCut = { fg = p.cyan },
    DashboardFiles = { fg = p.fg },
    DashboardProjectTitle = { fg = p.cyan },
    DashboardProjectIcon = { fg = p.pink },
    DashboardMruTitle = { fg = p.fg_dim },
    DashboardMruIcon = { fg = p.pink },
    DashboardShortCutIcon = { fg = p.pink },
  }
end

return { build = build }
