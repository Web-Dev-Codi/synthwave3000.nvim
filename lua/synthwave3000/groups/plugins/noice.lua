local function build(p, o)
  return {
    NoiceCmdline = { fg = p.fg, bg = p.bg_panel },
    NoiceCmdlinePopup = { fg = p.fg, bg = p.bg_panel },
    NoiceCmdlinePopupBorder = { fg = p.pink, bg = p.bg_panel },
    NoiceCmdlinePopupTitle = { fg = p.cyan, bold = true },
    NoiceConfirm = { fg = p.fg, bg = p.bg_panel },
    NoiceConfirmBorder = { fg = p.yellow, bg = p.bg_panel },
    NoiceFormatProgressDone = { fg = p.green, bg = p.green },
    NoiceFormatProgressTodo = { fg = p.bg_highlight, bg = p.bg_highlight },
    NoiceLspProgressClient = { fg = p.cyan },
    NoiceLspProgressSpinner = { fg = p.pink },
    NoiceLspProgressTitle = { fg = p.fg },
    NoiceMini = { fg = p.fg_dim },
    NoicePopup = { fg = p.fg, bg = p.bg_panel },
    NoicePopupBorder = { fg = p.pink, bg = p.bg_panel },
    NoicePopupmenu = { fg = p.fg, bg = p.bg_panel },
    NoicePopupmenuBorder = { fg = p.bg_highlight, bg = p.bg_panel },
    NoicePopupmenuMatch = { fg = p.cyan, bold = true },
    NoicePopupmenuSelected = { fg = p.fg, bg = p.bg_highlight },
    NoiceVirtualText = { fg = p.comment },
  }
end

return { build = build }
