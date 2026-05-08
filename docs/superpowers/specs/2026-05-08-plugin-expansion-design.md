# Plugin Highlight Group Expansion — synthwave3000.nvim

## Overview

Expand the colorscheme's plugin highlight group coverage from the current 17 plugins to ~30+, covering all major popular Neovim plugins. Each new plugin gets its own file under `lua/synthwave3000/groups/plugins/`, a config toggle in `config.lua`, and a guarded require in `groups/init.lua`.

## File List: New Plugin Files

| # | File | Plugin | Approx. Groups |
|---|------|--------|---------------|
| 1 | `lua/synthwave3000/groups/plugins/dashboard.lua` | dashboard-nvim | ~15 |
| 2 | `lua/synthwave3000/groups/plugins/aerial.lua` | aerial.nvim / navic | ~35 |
| 3 | `lua/synthwave3000/groups/plugins/dap.lua` | nvim-dap + nvim-dap-ui | ~25 |
| 4 | `lua/synthwave3000/groups/plugins/hop.lua` | hop.nvim | ~4 |
| 5 | `lua/synthwave3000/groups/plugins/leap.lua` | leap.nvim | ~5 |
| 6 | `lua/synthwave3000/groups/plugins/neogit.lua` | neogit | ~20 |
| 7 | `lua/synthwave3000/groups/plugins/render-markdown.lua` | render-markdown.nvim | ~30 |
| 8 | `lua/synthwave3000/groups/plugins/todo-comments.lua` | todo-comments.nvim | ~21 |
| 9 | `lua/synthwave3000/groups/plugins/dressing.lua` | dressing.nvim | ~1 |

## Files to Modify

| File | Change |
|------|--------|
| `lua/synthwave3000/config.lua` | Add `true` toggles for all 9 new plugins in `M.defaults.plugins` |
| `lua/synthwave3000/groups/init.lua` | Add guarded `require` and `merge` for each new plugin |
| `lua/synthwave3000/groups/plugins/snacks.lua` | Expand with all missing Snacks groups (~80+ groups) |
| `lua/synthwave3000/groups/plugins/mini.lua` | Expand with missing Mini modules (~70+ groups) |
| `lua/synthwave3000/groups/plugins/noice.lua` | Add missing `NoiceFormat*`, `NoiceScrollbar*` groups |
| `lua/synthwave3000/groups/plugins/telescope.lua` | Add missing `TelescopeResultsDiff*`, `TelescopeResult*` type icon groups |

## Design Principles

1. **Existing pattern** — Each plugin file exports `{ build = build }` with a `build(palette, opts)` function returning a table of `{ GroupName = { fg = ..., bg = ..., bold = true } }` specs.
2. **Transparency support** — Variables like `bg` are computed at the top: `local bg = o.transparent and "NONE" or p.bg_dark` for plugins that have their own window backgrounds.
3. **Default links for picker icons** — `SnacksPickerIcon*` groups link to their semantic defaults (no explicit color assignment). Same for `Aerial*` icon groups.
4. **Color reuse** — Use existing palette colors (pink, cyan, green, yellow, orange, red, purple, blue, fg, fg_dim, comment, bg_*, selection).

## Group-by-Group Details

### 1. dashboard-nvim (`dashboard.lua`)

```lua
{
  DashboardHeader       = { fg = p.pink, bold = true },
  DashboardFooter       = { fg = p.comment, italic = true },
  DashboardKey          = { fg = p.cyan, bold = true },
  DashboardDesc         = { fg = p.fg_dim },
  DashboardIcon         = { fg = p.pink },
  DashboardShortCut     = { fg = p.cyan },
  DashboardFiles        = { fg = p.fg },
  DashboardProjectTitle = { fg = p.cyan },
  DashboardProjectIcon  = { fg = p.pink },
  DashboardMruTitle     = { fg = p.fg_dim },
  DashboardMruIcon      = { fg = p.pink },
  DashboardShortCutIcon = { fg = p.pink },
}
```

### 2. aerial.nvim (`aerial.lua`)

Use default links for symbol kinds. Explicitly set the structural groups:

```lua
{
  AerialNormal     = { fg = p.fg, bg = bg },
  AerialNormalFloat = { fg = p.fg, bg = bg_float },
  AerialLine       = { fg = p.pink, bg = p.bg_highlight, bold = true },
  AerialLineNC     = { fg = p.fg, bg = p.bg_highlight },
  AerialGuide      = { fg = p.comment },
  AerialPrivate    = { fg = p.comment },
  AerialProtected  = { fg = p.comment },
  -- Aerial{Kind} and Aerial{Kind}Icon use default links (no explicit colors)
}
```

### 3. nvim-dap + nvim-dap-ui (`dap.lua`)

```lua
{
  -- nvim-dap
  DapStoppedLine           = { bg = p.bg_highlight },
  DapBreakpoint            = { fg = p.red },
  DapBreakpointCondition   = { fg = p.orange },
  DapBreakpointRejected    = { fg = p.red },
  DapLogPoint              = { fg = p.cyan },
  DapStopped               = { fg = p.green },
  -- nvim-dap-ui
  DapUIBreakpointsPath     = { fg = p.cyan },
  DapUIBreakpointsInfo     = { fg = p.cyan },
  DapUIBreakpointsCurrentLine = { fg = p.yellow, bold = true },
  DapUIScope               = { fg = p.pink, bold = true },
  DapUIType                = { fg = p.cyan },
  DapUIValue               = { fg = p.fg },
  DapUIVariable            = { fg = p.fg },
  DapUIDecoration          = { fg = p.comment },
  DapUIThread              = { fg = p.pink },
  DapUIStoppedThread       = { fg = p.green, bold = true },
  DapUIFrameName           = { fg = p.fg },
  DapUISource              = { fg = p.cyan },
  DapUILineNumber          = { fg = p.comment },
  DapUIFloatBorder         = { fg = p.pink },
  DapUIWatchesEmpty        = { fg = p.red },
  DapUIWatchesValue        = { fg = p.green },
  DapUIWatchesError        = { fg = p.red },
  DapUIModifiedValue       = { fg = p.orange },
  DapUIUnavailable         = { fg = p.comment },
}
```

### 4. hop.nvim (`hop.lua`)

```lua
{
  HopNextKey   = { fg = p.pink, bold = true },
  HopNextKey1  = { fg = p.cyan, bold = true },
  HopNextKey2  = { fg = p.purple },
  HopUnmatched = { fg = p.comment },
}
```

### 5. leap.nvim (`leap.lua`)

```lua
{
  LeapMatch          = { fg = p.bg, bg = p.pink, bold = true },
  LeapLabel          = { fg = p.pink, bold = true },
  LeapBackdrop       = { fg = p.comment },
  LeapLabelPrimary   = { fg = p.pink, bold = true },
  LeapLabelSecondary = { fg = p.cyan, bold = true },
}
```

### 6. neogit (`neogit.lua`)

```lua
{
  NeogitBranch                 = { fg = p.pink },
  NeogitRemote                 = { fg = p.purple },
  NeogitHunkHeader             = { fg = p.fg_dim, bg = p.bg_highlight },
  NeogitHunkHeaderHighlight    = { fg = p.fg, bg = p.selection },
  NeogitDiffContextHighlight   = { bg = p.bg_highlight },
  NeogitDiffDeleteHighlight    = { fg = p.red, bg = require("util").blend(p.red, bg, 0.15) },
  NeogitDiffAddHighlight       = { fg = p.green, bg = require("util").blend(p.green, bg, 0.15) },
  NeogitFilePath               = { fg = p.cyan },
  NeogitSectionHeader          = { fg = p.yellow, bold = true },
  NeogitObjectId               = { fg = p.yellow },
  NeogitStashName              = { fg = p.cyan },
  NeogitStashLabel             = { fg = p.fg_dim },
  NeogitChangeModified         = { fg = p.yellow },
  NeogitChangeAdded            = { fg = p.green },
  NeogitChangeDeleted          = { fg = p.red },
  NeogitChangeRenamed          = { fg = p.cyan },
  NeogitChangeCopied           = { fg = p.cyan },
  NeogitChangeUntracked        = { fg = p.comment },
  NeogitChangeUnmerged         = { fg = p.orange },
  NeogitGraphBold              = { bold = true },
  NeogitGraph                  = { fg = p.comment },
}
```

### 7. render-markdown.nvim (`render-markdown.lua`)

```lua
{
  RenderMarkdownH1              = { fg = p.pink, bold = true },
  RenderMarkdownH2              = { fg = p.red, bold = true },
  RenderMarkdownH3             = { fg = p.orange, bold = true },
  RenderMarkdownH4              = { fg = p.yellow, bold = true },
  RenderMarkdownH5              = { fg = p.green, bold = true },
  RenderMarkdownH6              = { fg = p.cyan, bold = true },
  RenderMarkdownH1Bg            = { bg = require("util").blend(p.pink, bg, 0.1) },
  RenderMarkdownH2Bg            = { bg = require("util").blend(p.red, bg, 0.1) },
  RenderMarkdownH3Bg            = { bg = require("util").blend(p.orange, bg, 0.1) },
  RenderMarkdownH4Bg            = { bg = require("util").blend(p.yellow, bg, 0.1) },
  RenderMarkdownH5Bg            = { bg = require("util").blend(p.green, bg, 0.1) },
  RenderMarkdownH6Bg            = { bg = require("util").blend(p.cyan, bg, 0.1) },
  RenderMarkdownCode            = { bg = p.bg_highlight },
  RenderMarkdownCodeBorder      = { bg = p.bg_highlight },
  RenderMarkdownCodeInfo        = { fg = p.cyan },
  RenderMarkdownCodeInline      = { fg = p.pink, bg = p.bg_highlight },
  RenderMarkdownQuote           = { fg = p.purple },
  RenderMarkdownBullet          = { fg = p.pink },
  RenderMarkdownDash            = { fg = p.comment },
  RenderMarkdownMath            = { fg = p.cyan },
  RenderMarkdownLink            = { fg = p.cyan, underline = true },
  RenderMarkdownLinkTitle       = { fg = p.cyan },
  RenderMarkdownWikiLink        = { fg = p.cyan, underline = true },
  RenderMarkdownUnchecked        = { fg = p.orange },
  RenderMarkdownChecked         = { fg = p.green },
  RenderMarkdownTodo            = { fg = p.yellow, bold = true },
  RenderMarkdownTableHead       = { fg = p.cyan },
  RenderMarkdownTableRow        = { fg = p.fg },
  RenderMarkdownSuccess         = { fg = p.green },
  RenderMarkdownInfo            = { fg = p.cyan },
  RenderMarkdownHint            = { fg = p.purple },
  RenderMarkdownWarn            = { fg = p.yellow },
  RenderMarkdownError           = { fg = p.red },
  RenderMarkdownIndent          = { fg = p.bg_highlight },
}
```

### 8. todo-comments.nvim (`todo-comments.lua`)

For each keyword (FIX, TODO, HACK, WARN, PERF, NOTE, TEST), define 3 groups (Fg, Bg, Sign). Use color-coded severity:

```lua
-- Colors per keyword:
-- FIX:    red    (error/fix)
-- TODO:   yellow (task)
-- HACK:   purple (experimental)
-- WARN:   orange (warning)
-- PERF:   cyan   (performance)
-- NOTE:   blue   (note)
-- TEST:   green  (testing)

local function keyword(fg_color, bg_color, sign_color)
  return { fg = fg_color, bg = bg_color, sign = sign_color }
end
```

Each keyword generates: `TodoFg{KEYWORD}`, `TodoBg{KEYWORD}`, `TodoSign{KEYWORD}`.

### 9. dressing.nvim (`dressing.lua`)

```lua
{
  DressingSelectIdx = { fg = p.pink, bold = true },
}
```

### Expanded: Snacks.nvim

Add all missing groups from the picker, window chrome, notifier, indent, and statuscolumn modules. Picker icon groups (`SnacksPickerIcon*`) keep default links (no explicit colors). Key additions:

**Window chrome:** `SnacksTitle`, `SnacksFooter`, `SnacksFooterDesc`, `SnacksFooterKey`, `SnacksWinSeparator`, `SnacksWinKey`, `SnacksWinKeySep`, `SnacksWinKeyDesc`, `SnacksInputNormal`, `SnacksInputBorder`, `SnacksInputTitle`, `SnacksInputPrompt`, `SnacksInputIcon`

**Picker structural:** `SnacksPickerPrompt`, `SnacksPickerDirectory`, `SnacksPickerFile`, `SnacksPickerDir`, `SnacksPickerIcon`, `SnacksPickerIconSource`, `SnacksPickerIconName`, `SnacksPickerIconCategory`, `SnacksPickerSearch`, `SnacksPickerLabel`, `SnacksPickerTotals`, `SnacksPickerComment`, `SnacksPickerDesc`, `SnacksPickerDelim`, `SnacksPickerDimmed`, `SnacksPickerCmd`, `SnacksPickerCmdBuiltin`, `SnacksPickerRow`, `SnacksPickerCol`, `SnacksPickerTree`, `SnacksPickerSpinner`, `SnacksPickerRule`, `SnacksPickerUnselected`, `SnacksPickerIdx`, `SnacksPickerBold`, `SnacksPickerItalic`, `SnacksPickerCode`, `SnacksPickerToggle`

**Picker git status:** All `SnacksPickerGitStatus*` groups

**Picker misc:** `SnacksPickerTime`, `SnacksPickerUndo*`, `SnacksPickerAu*`, `SnacksPickerDiagnostic*`, `SnacksPickerRegister`, `SnacksPickerKeymap*`, `SnacksPickerBuf*`, `SnacksPickerFileType`, `SnacksPickerMan*`, `SnacksPickerPickWin*`, `SnacksPickerLsp*`

**Notifier:** `SnacksNotifierBorder*`, `SnacksNotifierTitle*`, `SnacksNotifierFooter*` per level (Info, Warn, Error, Debug, Trace) + `SnacksNotifierIconDebug`, `SnacksNotifierIconTrace` + `SnacksNotifierHistory*`, `SnacksNotifierMinimal`

**Indent:** `SnacksIndent1` through `SnacksIndent8` for rainbow indent levels

**Statuscolumn:** `SnacksStatusColumnMark`

### Expanded: Mini.nvim

**MiniFiles:**
```lua
MiniFilesBorder         = { fg = p.bg_highlight },
MiniFilesBorderModified = { fg = p.orange },
MiniFilesCursorLine     = { bg = p.bg_highlight },
MiniFilesDirectory      = { fg = p.cyan },
MiniFilesFile           = { fg = p.fg },
MiniFilesNormal         = { fg = p.fg, bg = bg },
MiniFilesTitle          = { fg = p.pink },
MiniFilesTitleFocused   = { fg = p.cyan, bold = true },
```

**MiniJump:** `MiniJump`, `MiniJump2dDim`, `MiniJump2dSpot`, `MiniJump2dSpotAhead`, `MiniJump2dSpotUnique`

**MiniTrailspace:** `MiniTrailspace = { bg = p.bg_highlight }`

**MiniDiff:** `MiniDiffSignAdd`, `MiniDiffSignChange`, `MiniDiffSignDelete`, `MiniDiffOverAdd`, `MiniDiffOverChange`, `MiniDiffOverContext`, `MiniDiffOverDelete`

**MiniPick extras:** `MiniPickBorder`, `MiniPickBorderBusy`, `MiniPickBorderText`, `MiniPickIconDirectory`, `MiniPickIconFile`, `MiniPickHeader`, `MiniPickNormal`, `MiniPickPreviewLine`, `MiniPickPreviewRegion`, `MiniPickPromptCaret`, `MiniPickPromptPrefix`

**MiniStarter:** `MiniStarterCurrent`, `MiniStarterFooter`, `MiniStarterHeader`, `MiniStarterInactive`, `MiniStarterItem`, `MiniStarterItemBullet`, `MiniStarterItemPrefix`, `MiniStarterSection`, `MiniStarterQuery`

**MiniNotify:** `MiniNotifyBorder`, `MiniNotifyNormal`, `MiniNotifyTitle`

**MiniClue:** `MiniClueBorder`, `MiniClueDescGroup`, `MiniClueDescSingle`, `MiniClueNextKey`, `MiniClueNextKeyWithPostkeys`, `MiniClueSeparator`, `MiniClueTitle`

**MiniIcons:** `MiniIconsAzure`, `MiniIconsBlue`, `MiniIconsCyan`, `MiniIconsGreen`, `MiniIconsGrey`, `MiniIconsOrange`, `MiniIconsPurple`, `MiniIconsRed`, `MiniIconsYellow`

**MiniTest:** `MiniTestEmphasis`, `MiniTestFail`, `MiniTestPass`

**MiniMap:** `MiniMapNormal`, `MiniMapSymbolCount`, `MiniMapSymbolLine`, `MiniMapSymbolView`

### Expanded: Telescope

Add missing groups:
```lua
TelescopeResultsDiffAdd    = { fg = p.green },
TelescopeResultsDiffChange = { fg = p.yellow },
TelescopeResultsDiffDelete = { fg = p.red },
TelescopeResultsClass      = { fg = p.red },
TelescopeResultsConstant   = { fg = p.orange },
TelescopeResultsField      = { fg = p.cyan },
TelescopeResultsFunction   = { fg = p.cyan },
TelescopeResultsMethod     = { fg = p.cyan },
TelescopeResultsOperator   = { fg = p.yellow },
TelescopeResultsStruct     = { fg = p.red },
TelescopeResultsVariable   = { fg = p.pink },
TelescopeResultsNumber     = { fg = p.orange },
TelescopeResultsComment    = { fg = p.comment },
TelescopeResultsSpecialComment = { fg = p.comment },
TelescopePreviewHyphen     = { fg = p.comment },
TelescopePreviewDate       = { fg = p.cyan },
```

### Expanded: Noice

Add missing format and scrollbar groups:
```lua
NoiceFormatConfirm        = { fg = p.green },
NoiceFormatDebug          = { fg = p.comment },
NoiceFormatDate           = { fg = p.comment },
NoiceFormatError          = { fg = p.red },
NoiceFormatEvent          = { fg = p.cyan },
NoiceFormatKind           = { fg = p.purple },
NoiceFormatLevel          = { fg = p.pink },
NoiceFormatProgressTitle  = { fg = p.fg },
NoiceFormatTitle          = { fg = p.cyan },
NoiceFormatTrace          = { fg = p.comment },
NoiceFormatWarning        = { fg = p.yellow },
NoiceScrollbarThumb       = { bg = p.selection },
NoiceScrollbarTrack       = { bg = p.bg_highlight },
```

## Config Toggles

In `config.lua`, add to `M.defaults.plugins`:

```lua
dashboard = true,
aerial = true,
dap = true,
hop = true,
leap = true,
neogit = true,
render_markdown = true,
todo_comments = true,
dressing = true,
```

## init.lua Requires

In `groups/init.lua`, add guarded requires for each:
```lua
if opts.plugins.dashboard then merge(require("synthwave3000.groups.plugins.dashboard").build(palette, opts)) end
if opts.plugins.aerial then merge(require("synthwave3000.groups.plugins.aerial").build(palette, opts)) end
if opts.plugins.dap then merge(require("synthwave3000.groups.plugins.dap").build(palette, opts)) end
if opts.plugins.hop then merge(require("synthwave3000.groups.plugins.hop").build(palette, opts)) end
if opts.plugins.leap then merge(require("synthwave3000.groups.plugins.leap").build(palette, opts)) end
if opts.plugins.neogit then merge(require("synthwave3000.groups.plugins.neogit").build(palette, opts)) end
if opts.plugins.render_markdown then merge(require("synthwave3000.groups.plugins.render-markdown").build(palette, opts)) end
if opts.plugins.todo_comments then merge(require("synthwave3000.groups.plugins.todo-comments").build(palette, opts)) end
if opts.plugins.dressing then merge(require("synthwave3000.groups.plugins.dressing").build(palette, opts)) end
```

## Implementation Order

1. `config.lua` — add all new toggles
2. `groups/init.lua` — add all guarded requires
3. New files: `dashboard.lua`, `aerial.lua`, `dap.lua`, `hop.lua`, `leap.lua`, `neogit.lua`, `render-markdown.lua`, `todo-comments.lua`, `dressing.lua`
4. Expand: `snacks.lua` (picker, window, notifier, indent)
5. Expand: `mini.lua` (files, jump, trailspace, diff, pick, starter, notify, clue, icons, test, map)
6. Expand: `telescope.lua` (diff/result groups)
7. Expand: `noice.lua` (format/scrollbar groups)
