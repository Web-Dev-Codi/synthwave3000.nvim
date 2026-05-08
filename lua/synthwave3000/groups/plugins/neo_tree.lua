local function build(p, o)
  local bg = o.transparent and "NONE" or p.bg_dark
  return {
    NeoTreeNormal = { fg = p.fg, bg = bg },
    NeoTreeNormalNC = { fg = p.fg, bg = bg },
    NeoTreeFloatBorder = { fg = p.pink, bg = bg },
    NeoTreeFloatTitle = { fg = p.cyan, bg = bg, bold = true },
    NeoTreeTitleBar = { fg = p.fg, bg = p.bg_highlight },
    NeoTreeBufferNumber = { fg = p.fg_dim },
    NeoTreeCursorLine = { bg = p.bg_highlight },
    NeoTreeDimText = { fg = p.comment },
    NeoTreeDirectoryIcon = { fg = p.cyan },
    NeoTreeDirectoryName = { fg = p.cyan },
    NeoTreeDotfile = { fg = p.comment },
    NeoTreeFileIcon = { fg = p.fg },
    NeoTreeFileName = { fg = p.fg },
    NeoTreeFileNameOpened = { fg = p.pink },
    NeoTreeFilterTerm = { fg = p.cyan },
    NeoTreeGitAdded = { fg = p.green },
    NeoTreeGitConflict = { fg = p.orange },
    NeoTreeGitDeleted = { fg = p.red },
    NeoTreeGitIgnored = { fg = p.comment },
    NeoTreeGitModified = { fg = p.yellow },
    NeoTreeGitUnstaged = { fg = p.yellow },
    NeoTreeGitUntracked = { fg = p.comment },
    NeoTreeGitStaged = { fg = p.green },
    NeoTreeIndentMarker = { fg = p.comment },
    NeoTreeExpander = { fg = p.comment },
    NeoTreeMessage = { fg = p.cyan },
    NeoTreeModified = { fg = p.orange },
    NeoTreeRootName = { fg = p.pink, bold = true },
    NeoTreeSymbolicLinkTarget = { fg = p.cyan },
    NeoTreeWindowsHidden = { fg = p.comment },
  }
end

return { build = build }
