local function build(p, o)
  local bg = o.transparent and "NONE" or (o.background or p.bg)
  local bg_dark = o.transparent and "NONE" or p.bg_dark
  local bg_panel = o.transparent and "NONE" or p.bg_panel
  return {
    TelescopeNormal = { fg = p.fg, bg = bg_dark },
    TelescopeBorder = { fg = p.bg_highlight, bg = bg_dark },
    TelescopePromptNormal = { fg = p.fg, bg = bg_panel },
    TelescopePromptBorder = { fg = p.bg_highlight, bg = bg_panel },
    TelescopePromptTitle = { fg = p.bg, bg = p.pink },
    TelescopePromptCounter = { fg = p.fg_dim },
    TelescopePromptPrefix = { fg = p.pink },
    TelescopePreviewNormal = { fg = p.fg, bg = bg },
    TelescopePreviewBorder = { fg = p.bg_highlight, bg = bg },
    TelescopePreviewTitle = { fg = p.bg, bg = p.green },
    TelescopeResultsNormal = { fg = p.fg, bg = bg_dark },
    TelescopeResultsBorder = { fg = p.bg_highlight, bg = bg_dark },
    TelescopeResultsTitle = { fg = p.bg, bg = p.cyan },
    TelescopeSelection = { fg = p.fg, bg = p.bg_highlight },
    TelescopeSelectionCaret = { fg = p.pink },
    TelescopeMultiSelection = { fg = p.fg, bg = p.bg_highlight },
    TelescopeMultiIcon = { fg = p.orange },
    TelescopeMatching = { fg = p.cyan },
    TelescopeTitle = { fg = p.bg, bg = p.pink },
    TelescopeResultsDiffAdd = { fg = p.green },
    TelescopeResultsDiffChange = { fg = p.yellow },
    TelescopeResultsDiffDelete = { fg = p.red },
    TelescopeResultsClass = { fg = p.red },
    TelescopeResultsConstant = { fg = p.orange },
    TelescopeResultsField = { fg = p.cyan },
    TelescopeResultsFunction = { fg = p.cyan },
    TelescopeResultsMethod = { fg = p.cyan },
    TelescopeResultsOperator = { fg = p.yellow },
    TelescopeResultsStruct = { fg = p.red },
    TelescopeResultsVariable = { fg = p.pink },
    TelescopeResultsNumber = { fg = p.orange },
    TelescopeResultsComment = { fg = p.comment },
    TelescopeResultsSpecialComment = { fg = p.comment },
    TelescopePreviewHyphen = { fg = p.comment },
    TelescopePreviewDate = { fg = p.cyan },
  }
end

return { build = build }
