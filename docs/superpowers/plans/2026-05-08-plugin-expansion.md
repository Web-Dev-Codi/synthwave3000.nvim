# Plugin Highlight Group Expansion — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Expand plugin highlight group coverage from 17 to ~30 plugins

**Architecture:** Each plugin has a file under `lua/synthwave3000/groups/plugins/` exporting `{ build = build }`. Config toggles in `config.lua`, guarded requires in `groups/init.lua`. Palette from `palette.lua`, util from `util.lua` for blending/brightening.

**Tech Stack:** Lua, Neovim `nvim_set_hl` API

---

### Task 1: Add config toggles for 9 new plugins

**Files:**
- Modify: `lua/synthwave3000/config.lua:46`

- [ ] **Add new plugin toggles to defaults table**

Insert before the closing `}` of the plugins table (line 45):

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

---

### Task 2: Add guarded requires in groups/init.lua

**Files:**
- Modify: `lua/synthwave3000/groups/init.lua:64`

- [ ] **Add 9 guarded requires before `return groups`**

Insert before the `return groups` on line 66:

```lua

  if opts.plugins.dashboard then
    merge(require("synthwave3000.groups.plugins.dashboard").build(palette, opts))
  end
  if opts.plugins.aerial then
    merge(require("synthwave3000.groups.plugins.aerial").build(palette, opts))
  end
  if opts.plugins.dap then
    merge(require("synthwave3000.groups.plugins.dap").build(palette, opts))
  end
  if opts.plugins.hop then
    merge(require("synthwave3000.groups.plugins.hop").build(palette, opts))
  end
  if opts.plugins.leap then
    merge(require("synthwave3000.groups.plugins.leap").build(palette, opts))
  end
  if opts.plugins.neogit then
    merge(require("synthwave3000.groups.plugins.neogit").build(palette, opts))
  end
  if opts.plugins.render_markdown then
    merge(require("synthwave3000.groups.plugins.render-markdown").build(palette, opts))
  end
  if opts.plugins.todo_comments then
    merge(require("synthwave3000.groups.plugins.todo-comments").build(palette, opts))
  end
  if opts.plugins.dressing then
    merge(require("synthwave3000.groups.plugins.dressing").build(palette, opts))
  end
```

---

### Task 3: Create dashboard-nvim plugin file

**Files:**
- Create: `lua/synthwave3000/groups/plugins/dashboard.lua`

- [ ] **Create dashboard.lua with 12 highlight groups**

```lua
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
```

---

### Task 4: Create aerial.nvim plugin file

**Files:**
- Create: `lua/synthwave3000/groups/plugins/aerial.lua`

- [ ] **Create aerial.lua with structural groups and default links for kinds**

```lua
local function build(p, o)
  local bg = o.transparent and "NONE" or p.bg_dark
  local bg_float = o.transparent and "NONE" or p.bg_dark
  return {
    AerialNormal = { fg = p.fg, bg = bg },
    AerialNormalFloat = { fg = p.fg, bg = bg_float },
    AerialLine = { fg = p.pink, bg = p.bg_highlight, bold = true },
    AerialLineNC = { fg = p.fg, bg = p.bg_highlight },
    AerialGuide = { fg = p.comment },
    AerialPrivate = { fg = p.comment },
    AerialProtected = { fg = p.comment },
  }
end

return { build = build }
```

Note: `Aerial{Kind}` and `Aerial{Kind}Icon` use default links defined by aerial.nvim, no explicit colors needed.

---

### Task 5: Create nvim-dap + nvim-dap-ui plugin file

**Files:**
- Create: `lua/synthwave3000/groups/plugins/dap.lua`

- [ ] **Create dap.lua with ~20 highlight groups**

```lua
local function build(p, o)
  return {
    DapStoppedLine = { bg = p.bg_highlight },
    DapBreakpoint = { fg = p.red },
    DapBreakpointCondition = { fg = p.orange },
    DapBreakpointRejected = { fg = p.red },
    DapLogPoint = { fg = p.cyan },
    DapStopped = { fg = p.green },
    DapUIBreakpointsPath = { fg = p.cyan },
    DapUIBreakpointsInfo = { fg = p.cyan },
    DapUIBreakpointsCurrentLine = { fg = p.yellow, bold = true },
    DapUIScope = { fg = p.pink, bold = true },
    DapUIType = { fg = p.cyan },
    DapUIValue = { fg = p.fg },
    DapUIVariable = { fg = p.fg },
    DapUIDecoration = { fg = p.comment },
    DapUIThread = { fg = p.pink },
    DapUIStoppedThread = { fg = p.green, bold = true },
    DapUIFrameName = { fg = p.fg },
    DapUISource = { fg = p.cyan },
    DapUILineNumber = { fg = p.comment },
    DapUIFloatBorder = { fg = p.pink },
    DapUIWatchesEmpty = { fg = p.red },
    DapUIWatchesValue = { fg = p.green },
    DapUIWatchesError = { fg = p.red },
    DapUIModifiedValue = { fg = p.orange },
    DapUIUnavailable = { fg = p.comment },
  }
end

return { build = build }
```

---

### Task 6: Create hop.nvim plugin file

**Files:**
- Create: `lua/synthwave3000/groups/plugins/hop.lua`

- [ ] **Create hop.lua with 4 highlight groups**

```lua
local function build(p, o)
  return {
    HopNextKey = { fg = p.pink, bold = true },
    HopNextKey1 = { fg = p.cyan, bold = true },
    HopNextKey2 = { fg = p.purple },
    HopUnmatched = { fg = p.comment },
  }
end

return { build = build }
```

---

### Task 7: Create leap.nvim plugin file

**Files:**
- Create: `lua/synthwave3000/groups/plugins/leap.lua`

- [ ] **Create leap.lua with 5 highlight groups**

```lua
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
```

---

### Task 8: Create neogit plugin file

**Files:**
- Create: `lua/synthwave3000/groups/plugins/neogit.lua`

- [ ] **Create neogit.lua with ~22 highlight groups**

```lua
local function build(p, o)
  local bg = o.transparent and "NONE" or p.bg
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
```

---

### Task 9: Create render-markdown.nvim plugin file

**Files:**
- Create: `lua/synthwave3000/groups/plugins/render-markdown.lua`

- [ ] **Create render-markdown.lua with ~30 highlight groups**

```lua
local function build(p, o)
  local bg = o.transparent and "NONE" or p.bg
  local util = require("synthwave3000.util")
  return {
    RenderMarkdownH1 = { fg = p.pink, bold = true },
    RenderMarkdownH2 = { fg = p.red, bold = true },
    RenderMarkdownH3 = { fg = p.orange, bold = true },
    RenderMarkdownH4 = { fg = p.yellow, bold = true },
    RenderMarkdownH5 = { fg = p.green, bold = true },
    RenderMarkdownH6 = { fg = p.cyan, bold = true },
    RenderMarkdownH1Bg = { bg = util.blend(p.pink, bg, 0.1) },
    RenderMarkdownH2Bg = { bg = util.blend(p.red, bg, 0.1) },
    RenderMarkdownH3Bg = { bg = util.blend(p.orange, bg, 0.1) },
    RenderMarkdownH4Bg = { bg = util.blend(p.yellow, bg, 0.1) },
    RenderMarkdownH5Bg = { bg = util.blend(p.green, bg, 0.1) },
    RenderMarkdownH6Bg = { bg = util.blend(p.cyan, bg, 0.1) },
    RenderMarkdownCode = { bg = p.bg_highlight },
    RenderMarkdownCodeBorder = { bg = p.bg_highlight },
    RenderMarkdownCodeInfo = { fg = p.cyan },
    RenderMarkdownCodeInline = { fg = p.pink, bg = p.bg_highlight },
    RenderMarkdownQuote = { fg = p.purple },
    RenderMarkdownBullet = { fg = p.pink },
    RenderMarkdownDash = { fg = p.comment },
    RenderMarkdownMath = { fg = p.cyan },
    RenderMarkdownLink = { fg = p.cyan, underline = true },
    RenderMarkdownLinkTitle = { fg = p.cyan },
    RenderMarkdownWikiLink = { fg = p.cyan, underline = true },
    RenderMarkdownUnchecked = { fg = p.orange },
    RenderMarkdownChecked = { fg = p.green },
    RenderMarkdownTodo = { fg = p.yellow, bold = true },
    RenderMarkdownTableHead = { fg = p.cyan },
    RenderMarkdownTableRow = { fg = p.fg },
    RenderMarkdownSuccess = { fg = p.green },
    RenderMarkdownInfo = { fg = p.cyan },
    RenderMarkdownHint = { fg = p.purple },
    RenderMarkdownWarn = { fg = p.yellow },
    RenderMarkdownError = { fg = p.red },
    RenderMarkdownIndent = { fg = p.bg_highlight },
    RenderMarkdownSign = { fg = p.comment },
    RenderMarkdownHtmlComment = { fg = p.comment },
    RenderMarkdownInlineHighlight = { fg = p.pink, bg = p.bg_highlight },
  }
end

return { build = build }
```

---

### Task 10: Create todo-comments.nvim plugin file

**Files:**
- Create: `lua/synthwave3000/groups/plugins/todo-comments.lua`

- [ ] **Create todo-comments.lua with 21 highlight groups (7 keywords × 3 variants)**

```lua
local function build(p, o)
  return {
    TodoFgFIX = { fg = p.red },
    TodoBgFIX = { bg = p.bg_highlight },
    TodoSignFIX = { fg = p.red },
    TodoFgTODO = { fg = p.yellow },
    TodoBgTODO = { bg = p.bg_highlight },
    TodoSignTODO = { fg = p.yellow },
    TodoFgHACK = { fg = p.purple },
    TodoBgHACK = { bg = p.bg_highlight },
    TodoSignHACK = { fg = p.purple },
    TodoFgWARN = { fg = p.orange },
    TodoBgWARN = { bg = p.bg_highlight },
    TodoSignWARN = { fg = p.orange },
    TodoFgPERF = { fg = p.cyan },
    TodoBgPERF = { bg = p.bg_highlight },
    TodoSignPERF = { fg = p.cyan },
    TodoFgNOTE = { fg = p.blue },
    TodoBgNOTE = { bg = p.bg_highlight },
    TodoSignNOTE = { fg = p.blue },
    TodoFgTEST = { fg = p.green },
    TodoBgTEST = { bg = p.bg_highlight },
    TodoSignTEST = { fg = p.green },
  }
end

return { build = build }
```

---

### Task 11: Create dressing.nvim plugin file

**Files:**
- Create: `lua/synthwave3000/groups/plugins/dressing.lua`

- [ ] **Create dressing.lua with 1 highlight group**

```lua
local function build(p, o)
  return {
    DressingSelectIdx = { fg = p.pink, bold = true },
  }
end

return { build = build }
```

---

### Task 12: Expand snacks.lua with all missing groups

**Files:**
- Modify: `lua/synthwave3000/groups/plugins/snacks.lua`

- [ ] **Replace snacks.lua with expanded version (~90 groups)**

```lua
local function build(p, o)
  return {
    SnacksNormal = { fg = p.fg, bg = p.bg_dark },
    SnacksNormalNC = { fg = p.fg, bg = p.bg_dark },
    SnacksWinBar = { fg = p.fg, bg = p.bg_dark },
    SnacksWinBarNC = { fg = p.fg_dim, bg = p.bg_darker },
    SnacksTitle = { fg = p.cyan, bold = true },
    SnacksFooter = { fg = p.fg_dim },
    SnacksFooterDesc = { fg = p.fg_dim },
    SnacksFooterKey = { fg = p.pink },
    SnacksWinKey = { fg = p.yellow },
    SnacksWinKeySep = { fg = p.comment },
    SnacksWinKeyDesc = { fg = p.fg },
    SnacksWinSeparator = { fg = p.bg_highlight },
    SnacksBackdrop = { bg = p.bg_darker },
    SnacksDashboardNormal = { fg = p.fg, bg = p.bg },
    SnacksDashboardDesc = { fg = p.fg_dim },
    SnacksDashboardFile = { fg = p.fg },
    SnacksDashboardDir = { fg = p.cyan },
    SnacksDashboardFooter = { fg = p.comment, italic = true },
    SnacksDashboardHeader = { fg = p.pink, bold = true },
    SnacksDashboardIcon = { fg = p.pink },
    SnacksDashboardKey = { fg = p.cyan, bold = true },
    SnacksDashboardTerminal = { fg = p.green },
    SnacksDashboardSpecial = { fg = p.yellow },
    SnacksDashboardTitle = { fg = p.cyan, bold = true },
    SnacksIndent = { fg = p.bg_highlight },
    SnacksIndentScope = { fg = p.comment },
    SnacksIndentChunk = { fg = p.pink },
    SnacksIndent1 = { fg = p.pink },
    SnacksIndent2 = { fg = p.red },
    SnacksIndent3 = { fg = p.orange },
    SnacksIndent4 = { fg = p.yellow },
    SnacksIndent5 = { fg = p.green },
    SnacksIndent6 = { fg = p.cyan },
    SnacksIndent7 = { fg = p.blue },
    SnacksIndent8 = { fg = p.purple },
    SnacksNotifierInfo = { fg = p.cyan },
    SnacksNotifierWarn = { fg = p.yellow },
    SnacksNotifierError = { fg = p.red },
    SnacksNotifierDebug = { fg = p.comment },
    SnacksNotifierTrace = { fg = p.purple },
    SnacksNotifierIconInfo = { fg = p.cyan },
    SnacksNotifierIconWarn = { fg = p.yellow },
    SnacksNotifierIconError = { fg = p.red },
    SnacksNotifierIconDebug = { fg = p.comment },
    SnacksNotifierIconTrace = { fg = p.purple },
    SnacksNotifierBorderInfo = { fg = p.cyan },
    SnacksNotifierBorderWarn = { fg = p.yellow },
    SnacksNotifierBorderError = { fg = p.red },
    SnacksNotifierBorderDebug = { fg = p.comment },
    SnacksNotifierBorderTrace = { fg = p.purple },
    SnacksNotifierTitleInfo = { fg = p.cyan },
    SnacksNotifierTitleWarn = { fg = p.yellow },
    SnacksNotifierTitleError = { fg = p.red },
    SnacksNotifierTitleDebug = { fg = p.comment },
    SnacksNotifierTitleTrace = { fg = p.purple },
    SnacksNotifierFooterInfo = { fg = p.cyan },
    SnacksNotifierFooterWarn = { fg = p.yellow },
    SnacksNotifierFooterError = { fg = p.red },
    SnacksNotifierFooterDebug = { fg = p.comment },
    SnacksNotifierFooterTrace = { fg = p.purple },
    SnacksNotifierHistory = { fg = p.fg, bg = p.bg_dark },
    SnacksNotifierHistoryTitle = { fg = p.cyan, bold = true },
    SnacksNotifierHistoryDateTime = { fg = p.comment },
    SnacksNotifierMinimal = { fg = p.fg, bg = p.bg_dark },
    SnacksPickerBorder = { fg = p.bg_highlight },
    SnacksPickerInput = { fg = p.fg, bg = p.bg_panel },
    SnacksPickerList = { fg = p.fg, bg = p.bg },
    SnacksPickerPreview = { fg = p.fg, bg = p.bg },
    SnacksPickerMatch = { fg = p.cyan, bold = true },
    SnacksPickerSelected = { fg = p.pink, bold = true },
    SnacksPickerPrompt = { fg = p.cyan },
    SnacksPickerSearch = { bg = p.bg_highlight },
    SnacksPickerLabel = { fg = p.fg },
    SnacksPickerTotals = { fg = p.comment },
    SnacksPickerFile = { fg = p.fg },
    SnacksPickerLink = { fg = p.cyan },
    SnacksPickerLinkBroken = { fg = p.red },
    SnacksPickerDirectory = { fg = p.cyan },
    SnacksPickerPathIgnored = { fg = p.comment },
    SnacksPickerPathHidden = { fg = p.comment },
    SnacksPickerDir = { fg = p.comment },
    SnacksPickerToggle = { fg = p.cyan },
    SnacksPickerDimmed = { fg = p.comment },
    SnacksPickerRow = { fg = p.fg_dim },
    SnacksPickerCol = { fg = p.comment },
    SnacksPickerComment = { fg = p.comment },
    SnacksPickerDesc = { fg = p.fg_dim },
    SnacksPickerDelim = { fg = p.fg_dim },
    SnacksPickerSpinner = { fg = p.pink },
    SnacksPickerCmd = { fg = p.cyan },
    SnacksPickerCmdBuiltin = { fg = p.yellow },
    SnacksPickerUnselected = { fg = p.fg_dim },
    SnacksPickerIdx = { fg = p.orange },
    SnacksPickerBold = { bold = true },
    SnacksPickerTree = { fg = p.comment },
    SnacksPickerItalic = { italic = true },
    SnacksPickerCode = { fg = p.pink },
    SnacksPickerGitCommit = { fg = p.fg_dim },
    SnacksPickerGitBreaking = { fg = p.red },
    SnacksPickerGitDetached = { fg = p.orange },
    SnacksPickerGitBranch = { fg = p.pink },
    SnacksPickerGitBranchCurrent = { fg = p.green, bold = true },
    SnacksPickerGitDate = { fg = p.comment },
    SnacksPickerGitIssue = { fg = p.orange },
    SnacksPickerGitAuthor = { fg = p.cyan },
    SnacksPickerGitType = { fg = p.purple },
    SnacksPickerGitScope = { italic = true, fg = p.fg_dim },
    SnacksPickerGitStatus = { fg = p.fg_dim },
    SnacksPickerGitStatusAdded = { fg = p.green },
    SnacksPickerGitStatusModified = { fg = p.yellow },
    SnacksPickerGitStatusDeleted = { fg = p.red },
    SnacksPickerGitStatusRenamed = { fg = p.cyan },
    SnacksPickerGitStatusCopied = { fg = p.cyan },
    SnacksPickerGitStatusUntracked = { fg = p.comment },
    SnacksPickerGitStatusIgnored = { fg = p.comment },
    SnacksPickerGitStatusUnmerged = { fg = p.orange },
    SnacksPickerGitStatusStaged = { fg = p.green },
    SnacksPickerTime = { fg = p.comment },
    SnacksPickerRule = { fg = p.comment },
    SnacksPickerInputSearch = { fg = p.cyan },
    SnacksPickerPickWin = { bg = p.bg_highlight },
    SnacksPickerPickWinCurrent = { bg = p.selection },
    SnacksStatusColumnMark = { fg = p.cyan },
  }
end

return { build = build }
```

---

### Task 13: Expand mini.lua with all missing modules

**Files:**
- Modify: `lua/synthwave3000/groups/plugins/mini.lua`

- [ ] **Replace mini.lua with expanded version (~70 groups)**

```lua
local function build(p, o)
  local bg = o.transparent and "NONE" or p.bg
  return {
    MiniIndentscopeSymbol = { fg = p.comment },
    MiniStatuslineModeNormal = { fg = p.bg, bg = p.pink, bold = true },
    MiniStatuslineModeInsert = { fg = p.bg, bg = p.cyan, bold = true },
    MiniStatuslineModeVisual = { fg = p.bg, bg = p.purple, bold = true },
    MiniStatuslineModeReplace = { fg = p.bg, bg = p.orange, bold = true },
    MiniStatuslineModeCommand = { fg = p.bg, bg = p.yellow, bold = true },
    MiniStatuslineModeOther = { fg = p.bg, bg = p.comment, bold = true },
    MiniStatuslineDevinfo = { fg = p.fg_dim, bg = p.bg_dark },
    MiniStatuslineFilename = { fg = p.fg, bg = p.bg_dark },
    MiniStatuslineFileinfo = { fg = p.fg_dim, bg = p.bg_dark },
    MiniStatuslineInactive = { fg = p.fg_dim, bg = p.bg_darker },
    MiniTablineCurrent = { fg = p.pink, bg = p.bg, bold = true },
    MiniTablineVisible = { fg = p.fg, bg = p.bg_dark },
    MiniTablineHidden = { fg = p.fg_dim, bg = p.bg_darker },
    MiniTablineModifiedCurrent = { fg = p.orange, bg = p.bg },
    MiniTablineModifiedVisible = { fg = p.orange, bg = p.bg_dark },
    MiniTablineModifiedHidden = { fg = p.orange, bg = p.bg_darker },
    MiniTablineFill = { bg = p.bg_darker },
    MiniCursorword = { underline = true },
    MiniCursorwordCurrent = { underline = true },
    MiniHipatternsTodo = { fg = p.yellow, bg = p.bg_highlight, bold = true },
    MiniHipatternsNote = { fg = p.cyan, bg = p.bg_highlight },
    MiniHipatternsFixme = { fg = p.orange, bg = p.bg_highlight, bold = true },
    MiniHipatternsHack = { fg = p.purple, bg = p.bg_highlight },
    MiniPickPrompt = { fg = p.cyan },
    MiniPickMatchCurrent = { fg = p.fg, bg = p.bg_highlight },
    MiniPickMatchMarked = { fg = p.pink, bold = true },
    MiniPickMatchRanges = { fg = p.cyan, bold = true },
    MiniPickNormal = { fg = p.fg, bg = bg },
    MiniPickBorder = { fg = p.bg_highlight },
    MiniPickBorderBusy = { fg = p.cyan },
    MiniPickBorderText = { fg = p.pink },
    MiniPickIconDirectory = { fg = p.cyan },
    MiniPickIconFile = { fg = p.fg },
    MiniPickHeader = { fg = p.cyan, bold = true },
    MiniPickPreviewLine = { bg = p.bg_highlight },
    MiniPickPreviewRegion = { bg = p.selection },
    MiniPickPromptCaret = { fg = p.pink },
    MiniPickPromptPrefix = { fg = p.pink },
    MiniFilesBorder = { fg = p.bg_highlight },
    MiniFilesBorderModified = { fg = p.orange },
    MiniFilesCursorLine = { bg = p.bg_highlight },
    MiniFilesDirectory = { fg = p.cyan },
    MiniFilesFile = { fg = p.fg },
    MiniFilesNormal = { fg = p.fg, bg = bg },
    MiniFilesTitle = { fg = p.pink },
    MiniFilesTitleFocused = { fg = p.cyan, bold = true },
    MiniJump = { fg = p.pink, bold = true },
    MiniJump2dDim = { fg = p.comment },
    MiniJump2dSpot = { fg = p.pink, bold = true },
    MiniJump2dSpotAhead = { fg = p.cyan, bold = true },
    MiniJump2dSpotUnique = { fg = p.green, bold = true },
    MiniTrailspace = { bg = p.bg_highlight },
    MiniDiffSignAdd = { fg = p.green },
    MiniDiffSignChange = { fg = p.yellow },
    MiniDiffSignDelete = { fg = p.red },
    MiniDiffOverAdd = { fg = p.green, bg = require("synthwave3000.util").blend(p.green, bg, 0.15) },
    MiniDiffOverChange = { fg = p.yellow, bg = require("synthwave3000.util").blend(p.yellow, bg, 0.15) },
    MiniDiffOverContext = { bg = p.bg_highlight },
    MiniDiffOverDelete = { fg = p.red, bg = require("synthwave3000.util").blend(p.red, bg, 0.15) },
    MiniStarterCurrent = { bg = p.bg_highlight },
    MiniStarterFooter = { fg = p.comment, italic = true },
    MiniStarterHeader = { fg = p.pink, bold = true },
    MiniStarterInactive = { fg = p.comment },
    MiniStarterItem = { fg = p.fg },
    MiniStarterItemBullet = { fg = p.pink },
    MiniStarterItemPrefix = { fg = p.cyan },
    MiniStarterSection = { fg = p.cyan, bold = true },
    MiniStarterQuery = { fg = p.cyan },
    MiniNotifyBorder = { fg = p.pink },
    MiniNotifyNormal = { fg = p.fg, bg = p.bg_dark },
    MiniNotifyTitle = { fg = p.cyan, bold = true },
    MiniClueBorder = { fg = p.bg_highlight },
    MiniClueDescGroup = { fg = p.cyan, bold = true },
    MiniClueDescSingle = { fg = p.fg },
    MiniClueNextKey = { fg = p.pink },
    MiniClueNextKeyWithPostkeys = { fg = p.cyan },
    MiniClueSeparator = { fg = p.comment },
    MiniClueTitle = { fg = p.cyan, bold = true },
    MiniIconsAzure = { fg = p.blue },
    MiniIconsBlue = { fg = p.blue },
    MiniIconsCyan = { fg = p.cyan },
    MiniIconsGreen = { fg = p.green },
    MiniIconsGrey = { fg = p.comment },
    MiniIconsOrange = { fg = p.orange },
    MiniIconsPurple = { fg = p.purple },
    MiniIconsRed = { fg = p.red },
    MiniIconsYellow = { fg = p.yellow },
    MiniTestEmphasis = { bold = true },
    MiniTestFail = { fg = p.red, bold = true },
    MiniTestPass = { fg = p.green, bold = true },
    MiniMapNormal = { fg = p.fg_dim, bg = p.bg_darker },
    MiniMapSymbolCount = { fg = p.comment },
    MiniMapSymbolLine = { fg = p.fg_dim },
    MiniMapSymbolView = { fg = p.pink },
  }
end

return { build = build }
```

---

### Task 14: Expand telescope.lua with diff/result groups

**Files:**
- Modify: `lua/synthwave3000/groups/plugins/telescope.lua`

- [ ] **Add 16 missing highlight groups to telescope.lua**

Append to the existing return table, after the last entry (`TelescopeTitle`):

```lua
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
```

---

### Task 15: Expand noice.lua with format/scrollbar groups

**Files:**
- Modify: `lua/synthwave3000/groups/plugins/noice.lua`

- [ ] **Add 13 missing highlight groups to noice.lua**

Append to the existing return table, after the last entry (`NoiceVirtualText`):

```lua
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
```

---

### Task 16: Run verification tests

**Files:**
- Tests: `tests/synthwave3000_spec.lua`

- [ ] **Read and run existing tests to verify nothing broke**

```bash
cat tests/synthwave3000_spec.lua && nvim --headless -c "lua require('tests.minimal_init')" -c "lua require('tests.synthwave3000_spec')" -c "qa!"
```

Expected: Tests pass (no errors reported)

- [ ] **Verify the theme loads cleanly with transparent=true**

```bash
nvim --headless -c "lua require('synthwave3000').setup({transparent=true})" -c "lua require('synthwave3000').load()" -c "q"
```

Expected: No errors, Neovim exits cleanly
