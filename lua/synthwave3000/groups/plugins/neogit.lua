local function build(p, o)
  local bg = o.transparent and "NONE" or (o.background or p.bg)
  local util = require("synthwave3000.util")
  return {
    NeogitBranch = { fg = p.pink },
    NeogitRemote = { fg = p.purple },
    NeogitHunkHeader = { fg = p.fg_dim, bg = p.bg_highlight },
    NeogitHunkHeaderHighlight = { fg = p.fg, bg = p.selection },
    NeogitDiffContextHighlight = { bg = p.bg_highlight },
    NeogitDiffDeleteHighlight = { fg = p.red, bg = util.blend(p.red, bg, 0.15) },
    NeogitDiffAddHighlight = { fg = p.green, bg = util.blend(p.green, bg, 0.15) },
    NeogitFilePath = { fg = p.cyan },
    NeogitSectionHeader = { fg = p.yellow, bold = true },
    NeogitObjectId = { fg = p.yellow },
    NeogitStashName = { fg = p.cyan },
    NeogitStashLabel = { fg = p.fg_dim },
    NeogitChangeModified = { fg = p.yellow },
    NeogitChangeAdded = { fg = p.green },
    NeogitChangeDeleted = { fg = p.red },
    NeogitChangeRenamed = { fg = p.cyan },
    NeogitChangeCopied = { fg = p.cyan },
    NeogitChangeUntracked = { fg = p.comment },
    NeogitChangeUnmerged = { fg = p.orange },
    NeogitGraphBold = { bold = true },
    NeogitGraph = { fg = p.comment },
  }
end

return { build = build }
