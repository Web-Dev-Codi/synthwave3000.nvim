local function build(p, o)
  return {
    DiffviewNormal = { fg = p.fg, bg = p.bg_dark },
    DiffviewStatusAdded = { fg = p.green },
    DiffviewStatusModified = { fg = p.yellow },
    DiffviewStatusDeleted = { fg = p.red },
    DiffviewStatusRenamed = { fg = p.purple },
    DiffviewStatusUnknown = { fg = p.comment },
    DiffviewStatusUntracked = { fg = p.comment },
    DiffviewStatusIgnored = { fg = p.comment },
    DiffviewStatusUnmerged = { fg = p.orange },
    DiffviewFilePanelTitle = { fg = p.pink, bold = true },
    DiffviewFilePanelCounter = { fg = p.cyan },
    DiffviewFilePanelFileName = { fg = p.fg },
    DiffviewFilePanelPath = { fg = p.fg_dim },
    DiffviewFilePanelInsertions = { fg = p.green },
    DiffviewFilePanelDeletions = { fg = p.red },
    DiffviewFolderName = { fg = p.cyan },
    DiffviewFolderSign = { fg = p.cyan },
    DiffviewHash = { fg = p.comment },
    DiffviewReference = { fg = p.pink },
    DiffviewDate = { fg = p.fg_dim },
    DiffviewSecondaryLog = { fg = p.cyan },
  }
end

return { build = build }
