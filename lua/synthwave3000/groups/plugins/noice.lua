local function build(p, o)
  local bg_panel = o.transparent and "NONE" or p.bg_panel
  return {
    NoiceCmdline = { fg = p.fg, bg = bg_panel },
    NoiceCmdlinePopup = { fg = p.fg, bg = bg_panel },
    NoiceCmdlinePopupBorder = { fg = p.pink, bg = bg_panel },
    NoiceCmdlinePopupTitle = { fg = p.cyan, bold = true },
    NoiceConfirm = { fg = p.fg, bg = bg_panel },
    NoiceConfirmBorder = { fg = p.yellow, bg = bg_panel },
    NoiceFormatProgressDone = { fg = p.green, bg = p.green },
    NoiceFormatProgressTodo = { fg = p.bg_highlight, bg = p.bg_highlight },
    NoiceLspProgressClient = { fg = p.cyan },
    NoiceLspProgressSpinner = { fg = p.pink },
    NoiceLspProgressTitle = { fg = p.fg },
    NoiceMini = { fg = p.fg_dim },
    NoicePopup = { fg = p.fg, bg = bg_panel },
    NoicePopupBorder = { fg = p.pink, bg = bg_panel },
    NoicePopupmenu = { fg = p.fg, bg = bg_panel },
    NoicePopupmenuBorder = { fg = p.bg_highlight, bg = bg_panel },
    NoicePopupmenuMatch = { fg = p.cyan, bold = true },
    NoicePopupmenuSelected = { fg = p.fg, bg = p.bg_highlight },
    NoiceVirtualText = { fg = p.comment },
    NoiceFormatConfirm = { fg = p.green },
    NoiceFormatDebug = { fg = p.comment },
    NoiceFormatDate = { fg = p.comment },
    NoiceFormatError = { fg = p.red },
    NoiceFormatEvent = { fg = p.cyan },
    NoiceFormatKind = { fg = p.purple },
    NoiceFormatLevel = { fg = p.pink },
    NoiceFormatProgressTitle = { fg = p.fg },
    NoiceFormatTitle = { fg = p.cyan },
    NoiceFormatTrace = { fg = p.comment },
    NoiceFormatWarning = { fg = p.yellow },
    NoiceScrollbarThumb = { bg = p.selection },
    NoiceScrollbarTrack = { bg = p.bg_highlight },
  }
end

return { build = build }
