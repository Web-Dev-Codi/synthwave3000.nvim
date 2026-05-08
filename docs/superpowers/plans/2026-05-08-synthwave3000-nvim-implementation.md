# synthwave3000.nvim Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a production-ready Neovim colorscheme plugin with dark/light mode, full plugin support, and WCAG AA compliance.

**Architecture:** Canonical 6-step boot order (hi clear → termguicolors → colors_name → nvim_set_hl loop → terminal colors → return). Dual entry point (setup + load). Separate palette per style. Flat groups table merged from per-category files.

**Tech Stack:** Lua 5.1, Neovim 0.10+ API (nvim_set_hl), no external dependencies.

---

### Task 1: Scaffold Directory Structure

**Files:**
- Create: `colors/synthwave3000.lua`
- Create: `lua/synthwave3000/init.lua`
- Create: `lua/synthwave3000/config.lua`
- Create: `lua/synthwave3000/palette.lua`
- Create: `lua/synthwave3000/theme.lua`
- Create: `lua/synthwave3000/util.lua`
- Create: `lua/synthwave3000/terminal.lua`
- Create: `lua/synthwave3000/groups/init.lua`
- Create: `lua/synthwave3000/groups/editor.lua`
- Create: `lua/synthwave3000/groups/syntax.lua`
- Create: `lua/synthwave3000/groups/treesitter.lua`
- Create: `lua/synthwave3000/groups/lsp.lua`
- Create: `lua/synthwave3000/groups/plugins/telescope.lua`
- Create: `lua/synthwave3000/groups/plugins/nvim_tree.lua`
- Create: `lua/synthwave3000/groups/plugins/neo_tree.lua`
- Create: `lua/synthwave3000/groups/plugins/lualine.lua`
- Create: `lua/synthwave3000/groups/plugins/bufferline.lua`
- Create: `lua/synthwave3000/groups/plugins/gitsigns.lua`
- Create: `lua/synthwave3000/groups/plugins/diffview.lua`
- Create: `lua/synthwave3000/groups/plugins/nvim_cmp.lua`
- Create: `lua/synthwave3000/groups/plugins/blink_cmp.lua`
- Create: `lua/synthwave3000/groups/plugins/mini.lua`
- Create: `lua/synthwave3000/groups/plugins/indent_blankline.lua`
- Create: `lua/synthwave3000/groups/plugins/which_key.lua`
- Create: `lua/synthwave3000/groups/plugins/noice.lua`
- Create: `lua/synthwave3000/groups/plugins/notify.lua`
- Create: `lua/synthwave3000/groups/plugins/trouble.lua`
- Create: `lua/synthwave3000/groups/plugins/flash.lua`
- Create: `lua/synthwave3000/groups/plugins/snacks.lua`
- Create: `tests/minimal_init.lua`
- Create: `tests/synthwave3000_spec.lua`
- Create: `doc/synthwave3000.txt`

- [ ] **Step 1: Create all directories & empty files**

```bash
mkdir -p colors \
  lua/synthwave3000/groups/plugins \
  tests \
  doc

touch colors/synthwave3000.lua \
  lua/synthwave3000/init.lua \
  lua/synthwave3000/config.lua \
  lua/synthwave3000/palette.lua \
  lua/synthwave3000/theme.lua \
  lua/synthwave3000/util.lua \
  lua/synthwave3000/terminal.lua \
  lua/synthwave3000/groups/init.lua \
  lua/synthwave3000/groups/editor.lua \
  lua/synthwave3000/groups/syntax.lua \
  lua/synthwave3000/groups/treesitter.lua \
  lua/synthwave3000/groups/lsp.lua \
  lua/synthwave3000/groups/plugins/telescope.lua \
  lua/synthwave3000/groups/plugins/nvim_tree.lua \
  lua/synthwave3000/groups/plugins/neo_tree.lua \
  lua/synthwave3000/groups/plugins/lualine.lua \
  lua/synthwave3000/groups/plugins/bufferline.lua \
  lua/synthwave3000/groups/plugins/gitsigns.lua \
  lua/synthwave3000/groups/plugins/diffview.lua \
  lua/synthwave3000/groups/plugins/nvim_cmp.lua \
  lua/synthwave3000/groups/plugins/blink_cmp.lua \
  lua/synthwave3000/groups/plugins/mini.lua \
  lua/synthwave3000/groups/plugins/indent_blankline.lua \
  lua/synthwave3000/groups/plugins/which_key.lua \
  lua/synthwave3000/groups/plugins/noice.lua \
  lua/synthwave3000/groups/plugins/notify.lua \
  lua/synthwave3000/groups/plugins/trouble.lua \
  lua/synthwave3000/groups/plugins/flash.lua \
  lua/synthwave3000/groups/plugins/snacks.lua \
  tests/minimal_init.lua \
  tests/synthwave3000_spec.lua \
  doc/synthwave3000.txt
```

- [ ] **Step 2: Commit scaffold**

```bash
git add -A && git commit -m "chore: scaffold directory structure"
```

---

### Task 2: Implement colors/synthwave3000.lua — the single-line entry point

**Files:**
- Modify: `colors/synthwave3000.lua`

- [ ] **Step 1: Write the entry point**

Write to `colors/synthwave3000.lua`:

```lua
require("synthwave3000").load()
```

- [ ] **Step 2: Commit**

```bash
git add colors/synthwave3000.lua && git commit -m "feat: add colorscheme entry point"
```

---

### Task 3: Implement util.lua — color helpers

**Files:**
- Modify: `lua/synthwave3000/util.lua`

- [ ] **Step 1: Write util.lua with brighten, blend, and contrast functions**

Write to `lua/synthwave3000/util.lua`:

```lua
local M = {}

function M.hex_to_rgb(hex)
  hex = hex:gsub("#", "")
  return tonumber(hex:sub(1, 2), 16),
    tonumber(hex:sub(3, 4), 16),
    tonumber(hex:sub(5, 6), 16)
end

function M.rgb_to_hex(r, g, b)
  return string.format("#%02x%02x%02x", r, g, b)
end

function M.rgb_to_hsluv(r, g, b)
  r, g, b = r / 255, g / 255, b / 255
  local max, min = math.max(r, g, b), math.min(r, g, b)
  local l = (max + min) / 2
  if max == min then
    return 0, 0, l * 100
  end
  local d = max - min
  local s = l > 0.5 and d / (2 - max - min) or d / (max + min)
  local h = 0
  if max == r then
    h = (g - b) / d + (g < b and 6 or 0)
  elseif max == g then
    h = (b - r) / d + 2
  else
    h = (r - g) / d + 4
  end
  h = h / 6
  return h * 360, s * 100, l * 100
end

function M.hsluv_to_rgb(h, s, l)
  h, s, l = h / 360, s / 100, l / 100
  if s == 0 then
    l = l * 255
    return l, l, l
  end
  local function hue2rgb(p, q, t)
    if t < 0 then t = t + 1 end
    if t > 1 then t = t - 1 end
    if t < 1 / 6 then return p + (q - p) * 6 * t end
    if t < 1 / 2 then return q end
    if t < 2 / 3 then return p + (q - p) * (2 / 3 - t) * 6 end
    return p
  end
  local q = l < 0.5 and l * (1 + s) or l + s - l * s
  local p = 2 * l - q
  return hue2rgb(p, q, h + 1 / 3) * 255,
    hue2rgb(p, q, h) * 255,
    hue2rgb(p, q, h - 1 / 3) * 255
end

function M.brighten(hex, amount)
  local r, g, b = M.hex_to_rgb(hex)
  local h, s, l = M.rgb_to_hsluv(r, g, b)
  l = math.min(100, l + amount * 100)
  r, g, b = M.hsluv_to_rgb(h, s, l)
  return M.rgb_to_hex(math.floor(r + 0.5), math.floor(g + 0.5), math.floor(b + 0.5))
end

function M.darken(hex, amount)
  local r, g, b = M.hex_to_rgb(hex)
  local h, s, l = M.rgb_to_hsluv(r, g, b)
  l = math.max(0, l - amount * 100)
  r, g, b = M.hsluv_to_rgb(h, s, l)
  return M.rgb_to_hex(math.floor(r + 0.5), math.floor(g + 0.5), math.floor(b + 0.5))
end

function M.blend(fg, bg, alpha)
  local fr, fg_b, fb = M.hex_to_rgb(fg)
  local br, bg_b, bb = M.hex_to_rgb(bg)
  local function blend_channel(f, b)
    return math.floor(f * alpha + b * (1 - alpha) + 0.5)
  end
  return M.rgb_to_hex(
    blend_channel(fr, br),
    blend_channel(fg_b, bg_b),
    blend_channel(fb, bb)
  )
end

function M.contrast(fg, bg)
  local function lum(hex)
    local r, g, b = M.hex_to_rgb(hex)
    local function chan(c)
      c = c / 255
      return c <= 0.03928 and c / 12.92 or ((c + 0.055) / 1.055) ^ 2.4
    end
    return 0.2126 * chan(r) + 0.7152 * chan(g) + 0.0722 * chan(b)
  end
  local l1, l2 = lum(fg), lum(bg)
  if l1 < l2 then
    l1, l2 = l2, l1
  end
  return (l1 + 0.05) / (l2 + 0.05)
end

return M
```

- [ ] **Step 2: Commit**

```bash
git add lua/synthwave3000/util.lua && git commit -m "feat: add color utility functions (brighten, blend, contrast)"
```

---

### Task 4: Implement config.lua — defaults and extend

**Files:**
- Modify: `lua/synthwave3000/config.lua`

- [ ] **Step 1: Write config.lua with defaults**

Write to `lua/synthwave3000/config.lua`:

```lua
local M = {}

M.defaults = {
  style = "auto",
  transparent = false,
  background = nil,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { bold = true },
    functions = { bold = true },
    variables = {},
    strings = {},
    types = { bold = true },
    operators = {},
  },
  glow = {
    enabled = true,
    groups = { "Function", "Keyword", "Type", "@function", "@keyword", "@type" },
    bold = true,
    brighten = 0.10,
    background = false,
    bg_blend = 0.06,
  },
  on_colors = nil,
  on_highlights = nil,
  plugins = {
    telescope = true,
    nvim_tree = true,
    neo_tree = true,
    bufferline = true,
    lualine = true,
    gitsigns = true,
    diffview = true,
    cmp = true,
    blink_cmp = true,
    mini = true,
    indent_blankline = true,
    which_key = true,
    noice = true,
    notify = true,
    trouble = true,
    flash = true,
    snacks = true,
  },
}

function M.extend(opts)
  opts = opts or {}
  local config = vim.deepcopy(M.defaults)
  config = vim.tbl_deep_extend("force", config, opts)
  if config.style == "auto" then
    config.style = vim.o.background == "light" and "light" or "dark"
  end
  return config
end

return M
```

- [ ] **Step 2: Commit**

```bash
git add lua/synthwave3000/config.lua && git commit -m "feat: add config with defaults and extend function"
```

---

### Task 5: Implement palette.lua — dark + light palettes

**Files:**
- Modify: `lua/synthwave3000/palette.lua`

- [ ] **Step 1: Write palette.lua with both dark and light palettes**

Write to `lua/synthwave3000/palette.lua`:

```lua
local M = {}

local dark = {
  bg = "#262335",
  bg_dark = "#241b2f",
  bg_darker = "#171520",
  bg_panel = "#2a2139",
  bg_highlight = "#34294f",
  bg_visual = "#ffffff20",
  fg = "#ffffff",
  fg_dim = "#b6b1b1",
  comment = "#848bbd",
  pink = "#ff7edb",
  cyan = "#36f9f6",
  green = "#72f1b8",
  yellow = "#fede5d",
  orange = "#f97e72",
  orange_bright = "#ff8b39",
  red = "#fe4450",
  purple = "#b893ce",
  blue = "#03edf9",
  selection = "#463465",
  none = "NONE",
}

local light = {
  bg = "#f5f0ff",
  bg_dark = "#e8e0f0",
  bg_darker = "#ddd4e8",
  bg_panel = "#f0ebf8",
  bg_highlight = "#ddd4e8",
  bg_visual = "#1a1a2e20",
  fg = "#1a1a2e",
  fg_dim = "#5a5a7a",
  comment = "#7c7fa0",
  pink = "#c445a3",
  cyan = "#007777",
  green = "#2d8f5e",
  yellow = "#b0901f",
  orange = "#c0552a",
  orange_bright = "#d4652a",
  red = "#c62828",
  purple = "#7c5295",
  blue = "#0288d1",
  selection = "#d0c0e8",
  none = "NONE",
}

function M.build(opts)
  if opts.style == "light" then
    return vim.deepcopy(light)
  end
  return vim.deepcopy(dark)
end

return M
```

- [ ] **Step 2: Commit**

```bash
git add lua/synthwave3000/palette.lua && git commit -m "feat: add dark and light palettes"
```

---

### Task 6: Implement theme.lua — the 6-step boot sequence

**Files:**
- Modify: `lua/synthwave3000/theme.lua`

- [ ] **Step 1: Write theme.lua with the apply function**

Write to `lua/synthwave3000/theme.lua`:

```lua
local M = {}

function M.apply(opts)
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "synthwave3000"

  local palette = require("synthwave3000.palette").build(opts)
  if opts.on_colors then
    opts.on_colors(palette)
  end

  local groups = require("synthwave3000.groups").build(palette, opts)
  if opts.on_highlights then
    opts.on_highlights(groups, palette)
  end

  for name, spec in pairs(groups) do
    if type(spec) == "string" then
      vim.api.nvim_set_hl(0, name, { link = spec })
    else
      spec.default = false
      vim.api.nvim_set_hl(0, name, spec)
    end
  end

  if opts.terminal_colors then
    require("synthwave3000.terminal").apply(palette)
  end
end

return M
```

- [ ] **Step 2: Commit**

```bash
git add lua/synthwave3000/theme.lua && git commit -m "feat: add theme apply with 6-step boot sequence"
```

---

### Task 7: Implement init.lua — public API (setup + load)

**Files:**
- Modify: `lua/synthwave3000/init.lua`

- [ ] **Step 1: Write init.lua**

Write to `lua/synthwave3000/init.lua`:

```lua
local M = {}
M.config = nil

function M.setup(opts)
  M.config = require("synthwave3000.config").extend(opts)
end

function M.load(opts)
  if opts or not M.config then
    M.config = require("synthwave3000.config").extend(opts)
  end
  require("synthwave3000.theme").apply(M.config)
end

return M
```

- [ ] **Step 2: Commit**

```bash
git add lua/synthwave3000/init.lua && git commit -m "feat: add public API with setup and load"
```

---

### Task 8: Implement terminal.lua

**Files:**
- Modify: `lua/synthwave3000/terminal.lua`

- [ ] **Step 1: Write terminal.lua**

Write to `lua/synthwave3000/terminal.lua`:

```lua
local M = {}

function M.apply(p)
  local colors = {
    p.none,
    p.red,
    p.green,
    p.yellow,
    p.blue,
    p.pink,
    p.cyan,
    p.fg_dim,
    p.comment,
    p.red,
    p.green,
    p.yellow,
    p.blue,
    p.pink,
    p.cyan,
    p.fg,
  }

  for i, c in ipairs(colors) do
    vim.g["terminal_color_" .. (i - 1)] = c
  end
end

return M
```

- [ ] **Step 2: Commit**

```bash
git add lua/synthwave3000/terminal.lua && git commit -m "feat: add terminal color setup"
```

---

### Task 9: Implement groups/editor.lua — core editor highlights

**Files:**
- Modify: `lua/synthwave3000/groups/editor.lua`

- [ ] **Step 1: Write editor.lua with all core editor groups**

Write to `lua/synthwave3000/groups/editor.lua`:

```lua
local function build(p, o)
  local bg = o.transparent and "NONE" or (o.background or p.bg)
  local bg_float = o.transparent and "NONE" or p.bg_dark
  local bg_sidebar = o.transparent and "NONE" or p.bg_dark
  local glow_enabled = o.glow.enabled and o.style == "dark"

  local function glow_group(fg)
    if glow_enabled then
      return { fg = require("synthwave3000.util").brighten(fg, o.glow.brighten), bold = o.glow.bold }
    end
    return { fg = fg }
  end

  return {
    Normal = { fg = p.fg, bg = bg },
    NormalNC = { fg = p.fg, bg = bg },
    NormalFloat = { fg = p.fg, bg = bg_float },
    FloatBorder = { fg = p.pink, bg = bg_float },
    FloatTitle = { fg = p.cyan, bg = bg_float, bold = true },
    FloatFooter = { fg = p.fg_dim, bg = bg_float },
    ColorColumn = { bg = p.bg_highlight },
    Conceal = { fg = p.comment },
    Cursor = { fg = p.bg, bg = p.fg },
    lCursor = { fg = p.bg, bg = p.pink },
    CursorIM = { fg = p.bg, bg = p.pink },
    CursorColumn = { bg = p.bg_highlight },
    CursorLine = { bg = p.bg_highlight },
    CursorLineNr = { fg = p.pink, bold = true },
    CursorLineFold = { fg = p.comment },
    CursorLineSign = { fg = p.pink },
    Directory = { fg = p.cyan },
    DiffAdd = { fg = p.green, bg = require("synthwave3000.util").blend(p.green, bg, 0.15) },
    DiffChange = { fg = p.yellow, bg = require("synthwave3000.util").blend(p.yellow, bg, 0.15) },
    DiffDelete = { fg = p.red, bg = require("synthwave3000.util").blend(p.red, bg, 0.15) },
    DiffText = { fg = p.cyan, bg = require("synthwave3000.util").blend(p.cyan, bg, 0.25) },
    EndOfBuffer = { fg = bg },
    ErrorMsg = { fg = p.red, bold = true },
    VertSplit = { fg = p.bg_highlight },
    WinSeparator = { fg = p.bg_highlight },
    Folded = { fg = p.comment, bg = p.bg_highlight },
    FoldColumn = { fg = p.comment, bg = bg_sidebar },
    SignColumn = { bg = bg_sidebar },
    IncSearch = { fg = p.bg, bg = p.yellow },
    Substitute = { fg = p.bg, bg = p.orange },
    LineNr = { fg = p.comment },
    LineNrAbove = { fg = p.comment },
    LineNrBelow = { fg = p.comment },
    MatchParen = { fg = p.orange, bold = true },
    ModeMsg = { fg = p.fg, bold = true },
    MoreMsg = { fg = p.cyan, bold = true },
    NonText = { fg = p.comment },
    Pmenu = { fg = p.fg, bg = p.bg_panel },
    PmenuSel = { fg = p.bg, bg = p.pink },
    PmenuSbar = { bg = p.bg_highlight },
    PmenuThumb = { bg = p.selection },
    PmenuKind = { fg = p.cyan, bg = p.bg_panel },
    PmenuKindSel = { fg = p.bg, bg = p.pink },
    PmenuExtra = { fg = p.fg_dim, bg = p.bg_panel },
    PmenuExtraSel = { fg = p.bg, bg = p.pink },
    Question = { fg = p.cyan },
    QuickFixLine = { bg = p.bg_highlight },
    Search = { fg = p.bg, bg = p.cyan },
    CurSearch = { fg = p.bg, bg = p.pink },
    SpecialKey = { fg = p.comment },
    SpellBad = { sp = p.red, undercurl = true },
    SpellCap = { sp = p.yellow, undercurl = true },
    SpellLocal = { sp = p.cyan, undercurl = true },
    SpellRare = { sp = p.pink, undercurl = true },
    StatusLine = { fg = p.fg, bg = p.bg_dark },
    StatusLineNC = { fg = p.fg_dim, bg = p.bg_darker },
    StatusLineTerm = { fg = p.fg, bg = p.bg_dark },
    StatusLineTermNC = { fg = p.fg_dim, bg = p.bg_darker },
    TabLine = { fg = p.fg_dim, bg = p.bg_dark },
    TabLineFill = { bg = p.bg_darker },
    TabLineSel = { fg = p.pink, bg = p.bg, bold = true },
    Title = { fg = p.pink, bold = true },
    Visual = { bg = p.bg_visual },
    VisualNOS = { bg = p.bg_visual },
    WarningMsg = { fg = p.yellow },
    Whitespace = { fg = p.bg_highlight },
    WildMenu = { fg = p.bg, bg = p.pink },
    WinBar = { fg = p.fg, bg = p.bg_dark },
    WinBarNC = { fg = p.fg_dim, bg = p.bg_darker },
    MsgArea = { fg = p.fg },
    MsgSeparator = { fg = p.fg_dim },
    FloatShadow = { fg = p.bg_darker },
    FloatShadowThrough = { fg = p.bg_darker },
    Added = { fg = p.green },
    Changed = { fg = p.yellow },
    Removed = { fg = p.red },
  }
end

return { build = build }
```

- [ ] **Step 2: Commit**

```bash
git add lua/synthwave3000/groups/editor.lua && git commit -m "feat: add core editor highlight groups"
```

---

### Task 10: Implement groups/syntax.lua — legacy syntax groups

**Files:**
- Modify: `lua/synthwave3000/groups/syntax.lua`

- [ ] **Step 1: Write syntax.lua**

Write to `lua/synthwave3000/groups/syntax.lua`:

```lua
local function build(p, o)
  local util = require("synthwave3000.util")
  local glow_enabled = o.glow.enabled and o.style == "dark"

  local function maybe_glow(fg)
    if glow_enabled then
      return { fg = util.brighten(fg, o.glow.brighten), bold = o.glow.bold }
    end
    return { fg = fg }
  end

  return {
    Comment = { fg = p.comment, italic = o.styles.comments.italic ~= false },
    Constant = { fg = p.orange },
    String = { fg = p.orange_bright },
    Character = { fg = p.orange },
    Number = { fg = p.orange },
    Boolean = { fg = p.orange },
    Float = { fg = p.orange },
    Identifier = { fg = p.pink },
    Function = maybe_glow(p.cyan),
    Statement = { fg = p.yellow },
    Conditional = maybe_glow(p.yellow),
    Repeat = maybe_glow(p.yellow),
    Label = { fg = p.pink },
    Operator = { fg = p.yellow },
    Keyword = maybe_glow(p.yellow),
    Exception = maybe_glow(p.red),
    PreProc = { fg = p.purple },
    Include = { fg = p.green },
    Define = { fg = p.yellow },
    Macro = { fg = p.yellow },
    PreCondit = { fg = p.purple },
    Type = maybe_glow(p.red),
    StorageClass = maybe_glow(p.red),
    Structure = maybe_glow(p.red),
    Typedef = maybe_glow(p.red),
    Special = { fg = p.pink },
    SpecialChar = { fg = p.orange },
    Tag = { fg = p.green },
    Delimiter = { fg = p.fg_dim },
    SpecialComment = { fg = p.comment, italic = true },
    Debug = { fg = p.orange },
    Underlined = { underline = true },
    Ignore = { fg = p.fg_dim },
    Error = { fg = p.red, bold = true },
    Todo = { fg = p.yellow, bg = util.blend(p.yellow, p.bg, 0.15), bold = true },
  }
end

return { build = build }
```

- [ ] **Step 2: Commit**

```bash
git add lua/synthwave3000/groups/syntax.lua && git commit -m "feat: add legacy syntax highlight groups"
```

---

### Task 11: Implement groups/treesitter.lua — all @* groups

**Files:**
- Modify: `lua/synthwave3000/groups/treesitter.lua`

- [ ] **Step 1: Write treesitter.lua with all @* groups + old→new aliases**

Write to `lua/synthwave3000/groups/treesitter.lua`:

```lua
local function build(p, o)
  local util = require("synthwave3000.util")
  local glow_enabled = o.glow.enabled and o.style == "dark"

  local function maybe_glow(fg)
    if glow_enabled then
      return { fg = util.brighten(fg, o.glow.brighten), bold = o.glow.bold }
    end
    return { fg = fg }
  end

  local groups = {
    -- Variables
    ["@variable"] = { fg = p.pink },
    ["@variable.builtin"] = { fg = p.red },
    ["@variable.parameter"] = { fg = p.orange },
    ["@variable.member"] = { fg = p.pink },

    -- Constants
    ["@constant"] = { fg = p.orange },
    ["@constant.builtin"] = { fg = p.orange },
    ["@constant.macro"] = { fg = p.yellow },

    -- Modules
    ["@module"] = { fg = p.purple },
    ["@module.builtin"] = { fg = p.purple },

    -- Labels
    ["@label"] = { fg = p.pink },

    -- Strings
    ["@string"] = { fg = p.orange_bright },
    ["@string.documentation"] = { fg = p.green, italic = true },
    ["@string.regexp"] = { fg = p.orange },
    ["@string.escape"] = { fg = p.cyan },
    ["@string.special"] = { fg = p.green },
    ["@string.special.symbol"] = { fg = p.pink },
    ["@string.special.url"] = { fg = p.cyan, underline = true },

    -- Characters
    ["@character"] = { fg = p.orange },
    ["@character.special"] = { fg = p.orange },

    -- Booleans & Numbers
    ["@boolean"] = { fg = p.orange },
    ["@number"] = { fg = p.orange },
    ["@number.float"] = { fg = p.orange },

    -- Types
    ["@type"] = maybe_glow(p.red),
    ["@type.builtin"] = maybe_glow(p.red),
    ["@type.definition"] = maybe_glow(p.red),

    -- Attributes
    ["@attribute"] = { fg = p.yellow },
    ["@attribute.builtin"] = { fg = p.yellow },

    -- Properties
    ["@property"] = { fg = p.pink },

    -- Functions
    ["@function"] = maybe_glow(p.cyan),
    ["@function.builtin"] = maybe_glow(p.cyan),
    ["@function.call"] = maybe_glow(p.cyan),
    ["@function.macro"] = { fg = p.yellow },
    ["@function.method"] = maybe_glow(p.cyan),
    ["@function.method.call"] = maybe_glow(p.cyan),

    -- Constructors
    ["@constructor"] = { fg = p.yellow },

    -- Operators
    ["@operator"] = { fg = p.yellow },

    -- Keywords
    ["@keyword"] = maybe_glow(p.yellow),
    ["@keyword.coroutine"] = maybe_glow(p.yellow),
    ["@keyword.function"] = maybe_glow(p.yellow),
    ["@keyword.operator"] = maybe_glow(p.yellow),
    ["@keyword.import"] = { fg = p.green },
    ["@keyword.type"] = maybe_glow(p.red),
    ["@keyword.modifier"] = maybe_glow(p.yellow),
    ["@keyword.repeat"] = maybe_glow(p.yellow),
    ["@keyword.return"] = maybe_glow(p.yellow),
    ["@keyword.debug"] = { fg = p.orange },
    ["@keyword.exception"] = maybe_glow(p.red),
    ["@keyword.conditional"] = maybe_glow(p.yellow),
    ["@keyword.conditional.ternary"] = maybe_glow(p.yellow),
    ["@keyword.directive"] = { fg = p.purple },
    ["@keyword.directive.define"] = { fg = p.purple },

    -- Punctuation
    ["@punctuation.delimiter"] = { fg = p.fg_dim },
    ["@punctuation.bracket"] = { fg = p.fg_dim },
    ["@punctuation.special"] = { fg = p.cyan },

    -- Comments
    ["@comment"] = { fg = p.comment, italic = o.styles.comments.italic ~= false },
    ["@comment.documentation"] = { fg = p.comment, italic = true },
    ["@comment.error"] = { fg = p.red, bold = true },
    ["@comment.warning"] = { fg = p.yellow },
    ["@comment.todo"] = { fg = p.orange, bold = true },
    ["@comment.note"] = { fg = p.cyan, italic = true },

    -- Markup (new 0.11+ names)
    ["@markup.strong"] = { bold = true },
    ["@markup.italic"] = { italic = true },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.heading"] = { fg = p.pink, bold = true },
    ["@markup.heading.1"] = { fg = p.pink, bold = true },
    ["@markup.heading.2"] = { fg = p.cyan, bold = true },
    ["@markup.heading.3"] = { fg = p.yellow, bold = true },
    ["@markup.heading.4"] = { fg = p.pink, bold = true },
    ["@markup.heading.5"] = { fg = p.cyan, bold = true },
    ["@markup.heading.6"] = { fg = p.yellow, bold = true },
    ["@markup.quote"] = { fg = p.fg_dim, italic = true },
    ["@markup.math"] = { fg = p.orange },
    ["@markup.environment"] = { fg = p.purple },
    ["@markup.link"] = { fg = p.cyan, underline = true },
    ["@markup.link.label"] = { fg = p.pink },
    ["@markup.link.url"] = { fg = p.cyan, underline = true },
    ["@markup.raw"] = { fg = p.green },
    ["@markup.raw.block"] = { fg = p.green },
    ["@markup.list"] = { fg = p.cyan },
    ["@markup.list.checked"] = { fg = p.green },
    ["@markup.list.unchecked"] = { fg = p.fg_dim },

    -- Diff
    ["@diff.plus"] = { fg = p.green },
    ["@diff.minus"] = { fg = p.red },
    ["@diff.delta"] = { fg = p.yellow },

    -- Tags
    ["@tag"] = { fg = p.green },
    ["@tag.builtin"] = { fg = p.red },
    ["@tag.attribute"] = { fg = p.yellow },
    ["@tag.delimiter"] = { fg = p.fg_dim },
  }

  -- Backward-compatible @text.* → @markup.* links
  local aliases = {
    ["@text"] = "@markup",
    ["@text.literal"] = "@markup.raw",
    ["@text.reference"] = "@markup.link",
    ["@text.title"] = "@markup.heading",
    ["@text.uri"] = "@markup.link.url",
    ["@text.underline"] = "@markup.underline",
    ["@text.todo"] = "@comment.todo",
    ["@text.note"] = "@comment.note",
    ["@text.warning"] = "@comment.warning",
    ["@text.danger"] = "@comment.error",
    ["@text.diff.add"] = "@diff.plus",
    ["@text.diff.delete"] = "@diff.minus",
    ["@punctuation.special"] = "@markup.list",
    ["@string.regex"] = "@string.regexp",
    ["@parameter"] = "@variable.parameter",
    ["@field"] = "@variable.member",
    ["@namespace"] = "@module",
    ["@symbol"] = "@string.special.symbol",
  }

  for old, new in pairs(aliases) do
    groups[old] = new
  end

  return groups
end

return { build = build }
```

- [ ] **Step 2: Commit**

```bash
git add lua/synthwave3000/groups/treesitter.lua && git commit -m "feat: add tree-sitter highlight groups with old→new aliases"
```

---

### Task 12: Implement groups/lsp.lua — diagnostic + semantic tokens

**Files:**
- Modify: `lua/synthwave3000/groups/lsp.lua`

- [ ] **Step 1: Write lsp.lua**

Write to `lua/synthwave3000/groups/lsp.lua`:

```lua
local function build(p, o)
  local util = require("synthwave3000.util")

  return {
    -- Diagnostic
    DiagnosticError = { fg = p.red },
    DiagnosticWarn = { fg = p.yellow },
    DiagnosticInfo = { fg = p.cyan },
    DiagnosticHint = { fg = p.purple },
    DiagnosticOk = { fg = p.green },
    DiagnosticVirtualTextError = { fg = p.red },
    DiagnosticVirtualTextWarn = { fg = p.yellow },
    DiagnosticVirtualTextInfo = { fg = p.cyan },
    DiagnosticVirtualTextHint = { fg = p.purple },
    DiagnosticVirtualTextOk = { fg = p.green },
    DiagnosticUnderlineError = { sp = p.red, undercurl = true },
    DiagnosticUnderlineWarn = { sp = p.yellow, undercurl = true },
    DiagnosticUnderlineInfo = { sp = p.cyan, undercurl = true },
    DiagnosticUnderlineHint = { sp = p.purple, undercurl = true },
    DiagnosticUnderlineOk = { sp = p.green, undercurl = true },
    DiagnosticFloatingError = { fg = p.red },
    DiagnosticFloatingWarn = { fg = p.yellow },
    DiagnosticFloatingInfo = { fg = p.cyan },
    DiagnosticFloatingHint = { fg = p.purple },
    DiagnosticFloatingOk = { fg = p.green },
    DiagnosticSignError = { fg = p.red },
    DiagnosticSignWarn = { fg = p.yellow },
    DiagnosticSignInfo = { fg = p.cyan },
    DiagnosticSignHint = { fg = p.purple },
    DiagnosticSignOk = { fg = p.green },
    DiagnosticDeprecated = { sp = p.red, strikethrough = true },
    DiagnosticUnnecessary = { fg = p.fg_dim },

    -- LSP semantic tokens
    ["@lsp.type.class"] = "@type",
    ["@lsp.type.decorator"] = "@function",
    ["@lsp.type.enum"] = "@type",
    ["@lsp.type.enumMember"] = "@constant",
    ["@lsp.type.event"] = "@function",
    ["@lsp.type.function"] = "@function",
    ["@lsp.type.interface"] = "@type",
    ["@lsp.type.keyword"] = "@keyword",
    ["@lsp.type.macro"] = "@function.macro",
    ["@lsp.type.method"] = "@function.method",
    ["@lsp.type.modifier"] = "@keyword.modifier",
    ["@lsp.type.namespace"] = "@module",
    ["@lsp.type.number"] = "@number",
    ["@lsp.type.operator"] = "@operator",
    ["@lsp.type.parameter"] = "@variable.parameter",
    ["@lsp.type.property"] = "@property",
    ["@lsp.type.regexp"] = "@string.regexp",
    ["@lsp.type.string"] = "@string",
    ["@lsp.type.struct"] = "@type",
    ["@lsp.type.type"] = "@type",
    ["@lsp.type.typeParameter"] = "@type.definition",
    ["@lsp.type.variable"] = "@variable",

    ["@lsp.typemod.function.declaration"] = "@function",
    ["@lsp.typemod.function.defaultLibrary"] = "@function.builtin",
    ["@lsp.typemod.function.readonly"] = "@function",
    ["@lsp.typemod.method.declaration"] = "@function.method",
    ["@lsp.typemod.method.defaultLibrary"] = "@function.builtin",
    ["@lsp.typemod.method.readonly"] = "@function.method",
    ["@lsp.typemod.operator.readonly"] = "@operator",
    ["@lsp.typemod.parameter.readonly"] = "@variable.parameter",
    ["@lsp.typemod.property.readonly"] = "@property",
    ["@lsp.typemod.type.declaration"] = "@type",
    ["@lsp.typemod.type.defaultLibrary"] = "@type.builtin",
    ["@lsp.typemod.type.readonly"] = "@type",
    ["@lsp.typemod.variable.callable"] = "@function",
    ["@lsp.typemod.variable.declaration"] = "@variable",
    ["@lsp.typemod.variable.defaultLibrary"] = "@variable.builtin",
    ["@lsp.typemod.variable.global"] = "@variable",
    ["@lsp.typemod.variable.injected"] = "@variable",
    ["@lsp.typemod.variable.readonly"] = "@variable.member",
    ["@lsp.typemod.variable.static"] = "@variable",
  }
end

return { build = build }
```

- [ ] **Step 2: Commit**

```bash
git add lua/synthwave3000/groups/lsp.lua && git commit -m "feat: add LSP diagnostic and semantic token groups"
```

---

### Task 13: Implement groups/init.lua — aggregate all groups

**Files:**
- Modify: `lua/synthwave3000/groups/init.lua`

- [ ] **Step 1: Write groups/init.lua**

Write to `lua/synthwave3000/groups/init.lua`:

```lua
local M = {}

function M.build(palette, opts)
  local groups = {}

  local function merge(t)
    for name, spec in pairs(t) do
      groups[name] = spec
    end
  end

  merge(require("synthwave3000.groups.editor").build(palette, opts))
  merge(require("synthwave3000.groups.syntax").build(palette, opts))
  merge(require("synthwave3000.groups.treesitter").build(palette, opts))
  merge(require("synthwave3000.groups.lsp").build(palette, opts))

  if opts.plugins.telescope then
    merge(require("synthwave3000.groups.plugins.telescope").build(palette, opts))
  end
  if opts.plugins.nvim_tree then
    merge(require("synthwave3000.groups.plugins.nvim_tree").build(palette, opts))
  end
  if opts.plugins.neo_tree then
    merge(require("synthwave3000.groups.plugins.neo_tree").build(palette, opts))
  end
  if opts.plugins.bufferline then
    merge(require("synthwave3000.groups.plugins.bufferline").build(palette, opts))
  end
  if opts.plugins.gitsigns then
    merge(require("synthwave3000.groups.plugins.gitsigns").build(palette, opts))
  end
  if opts.plugins.diffview then
    merge(require("synthwave3000.groups.plugins.diffview").build(palette, opts))
  end
  if opts.plugins.cmp then
    merge(require("synthwave3000.groups.plugins.nvim_cmp").build(palette, opts))
  end
  if opts.plugins.blink_cmp then
    merge(require("synthwave3000.groups.plugins.blink_cmp").build(palette, opts))
  end
  if opts.plugins.mini then
    merge(require("synthwave3000.groups.plugins.mini").build(palette, opts))
  end
  if opts.plugins.indent_blankline then
    merge(require("synthwave3000.groups.plugins.indent_blankline").build(palette, opts))
  end
  if opts.plugins.which_key then
    merge(require("synthwave3000.groups.plugins.which_key").build(palette, opts))
  end
  if opts.plugins.noice then
    merge(require("synthwave3000.groups.plugins.noice").build(palette, opts))
  end
  if opts.plugins.notify then
    merge(require("synthwave3000.groups.plugins.notify").build(palette, opts))
  end
  if opts.plugins.trouble then
    merge(require("synthwave3000.groups.plugins.trouble").build(palette, opts))
  end
  if opts.plugins.flash then
    merge(require("synthwave3000.groups.plugins.flash").build(palette, opts))
  end
  if opts.plugins.snacks then
    merge(require("synthwave3000.groups.plugins.snacks").build(palette, opts))
  end

  return groups
end

return M
```

- [ ] **Step 2: Commit**

```bash
git add lua/synthwave3000/groups/init.lua && git commit -m "feat: add groups aggregator"
```

---

### Task 14: Implement all plugin group files

**Files:**
- Modify: all `lua/synthwave3000/groups/plugins/*.lua`

- [ ] **Step 1: Write telescope.lua**

Write to `lua/synthwave3000/groups/plugins/telescope.lua`:

```lua
local function build(p, o)
  return {
    TelescopeNormal = { fg = p.fg, bg = p.bg_dark },
    TelescopeBorder = { fg = p.bg_highlight, bg = p.bg_dark },
    TelescopePromptNormal = { fg = p.fg, bg = p.bg_panel },
    TelescopePromptBorder = { fg = p.bg_highlight, bg = p.bg_panel },
    TelescopePromptTitle = { fg = p.bg, bg = p.pink },
    TelescopePromptCounter = { fg = p.fg_dim },
    TelescopePromptPrefix = { fg = p.pink },
    TelescopePreviewNormal = { fg = p.fg, bg = p.bg },
    TelescopePreviewBorder = { fg = p.bg_highlight, bg = p.bg },
    TelescopePreviewTitle = { fg = p.bg, bg = p.green },
    TelescopeResultsNormal = { fg = p.fg, bg = p.bg_dark },
    TelescopeResultsBorder = { fg = p.bg_highlight, bg = p.bg_dark },
    TelescopeResultsTitle = { fg = p.bg, bg = p.cyan },
    TelescopeSelection = { fg = p.fg, bg = p.bg_highlight },
    TelescopeSelectionCaret = { fg = p.pink },
    TelescopeMultiSelection = { fg = p.fg, bg = p.bg_highlight },
    TelescopeMultiIcon = { fg = p.orange },
    TelescopeMatching = { fg = p.cyan },
    TelescopeTitle = { fg = p.bg, bg = p.pink },
  }
end

return { build = build }
```

- [ ] **Step 2: Write nvim_tree.lua**

Write to `lua/synthwave3000/groups/plugins/nvim_tree.lua`:

```lua
local function build(p, o)
  local bg = o.transparent and "NONE" or p.bg_dark
  return {
    NvimTreeNormal = { fg = p.fg, bg = bg },
    NvimTreeNormalFloat = { fg = p.fg, bg = bg },
    NvimTreeNormalNC = { fg = p.fg, bg = bg },
    NvimTreeLineNr = { fg = p.comment },
    NvimTreeWinSeparator = { fg = p.bg_highlight, bg = bg },
    NvimTreeEndOfBuffer = { fg = bg, bg = bg },
    NvimTreePopup = { fg = p.fg, bg = p.bg_panel },
    NvimTreeSignColumn = { bg = bg },
    NvimTreeCursorColumn = { bg = p.bg_highlight },
    NvimTreeCursorLine = { bg = p.bg_highlight },
    NvimTreeCursorLineNr = { fg = p.pink },
    NvimTreeStatusLine = { fg = p.fg_dim, bg = p.bg_darker },
    NvimTreeStatusLineNC = { fg = p.fg_dim, bg = p.bg_darker },
    NvimTreeFolderName = { fg = p.cyan },
    NvimTreeOpenedFolderName = { fg = p.cyan },
    NvimTreeEmptyFolderName = { fg = p.comment },
    NvimTreeFolderIcon = { fg = p.cyan },
    NvimTreeRootFolder = { fg = p.pink, bold = true },
    NvimTreeSymlink = { fg = p.cyan },
    NvimTreeExecFile = { fg = p.green },
    NvimTreeFileIcon = { fg = p.fg },
    NvimTreeOpenedFile = { fg = p.pink },
    NvimTreeOpenedHL = { fg = p.pink },
    NvimTreeModifiedFile = { fg = p.orange },
    NvimTreeGitDirty = { fg = p.yellow },
    NvimTreeGitStaged = { fg = p.green },
    NvimTreeGitMerge = { fg = p.purple },
    NvimTreeGitRenamed = { fg = p.purple },
    NvimTreeGitNew = { fg = p.green },
    NvimTreeGitDeleted = { fg = p.red },
    NvimTreeGitIgnored = { fg = p.comment },
    NvimTreeWindowPicker = { fg = p.pink, bg = p.bg_highlight },
    NvimTreeIndentMarker = { fg = p.comment },
  }
end

return { build = build }
```

- [ ] **Step 3: Write neo_tree.lua**

Write to `lua/synthwave3000/groups/plugins/neo_tree.lua`:

```lua
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
```

- [ ] **Step 4: Write bufferline.lua**

Write to `lua/synthwave3000/groups/plugins/bufferline.lua`:

```lua
local function build(p, o)
  return {
    BufferLineFill = { bg = p.bg_darker },
    BufferLineBackground = { fg = p.fg_dim, bg = p.bg_dark },
    BufferLineBufferVisible = { fg = p.fg_dim, bg = p.bg_dark },
    BufferLineBufferSelected = { fg = p.pink, bg = p.bg, bold = true },
    BufferLineCloseButton = { fg = p.fg_dim, bg = p.bg_dark },
    BufferLineCloseButtonVisible = { fg = p.fg_dim, bg = p.bg_dark },
    BufferLineCloseButtonSelected = { fg = p.red, bg = p.bg },
    BufferLineModified = { fg = p.orange, bg = p.bg_dark },
    BufferLineModifiedVisible = { fg = p.orange, bg = p.bg_dark },
    BufferLineModifiedSelected = { fg = p.orange, bg = p.bg },
    BufferLineIndicatorSelected = { fg = p.pink, bg = p.bg },
    BufferLineSeparator = { fg = p.bg_highlight, bg = p.bg_darker },
    BufferLineSeparatorVisible = { fg = p.bg_highlight, bg = p.bg_dark },
    BufferLineSeparatorSelected = { fg = p.bg, bg = p.bg },
    BufferLineTab = { fg = p.fg_dim, bg = p.bg_darker },
    BufferLineTabSelected = { fg = p.pink, bg = p.bg },
    BufferLineNumbers = { fg = p.fg_dim, bg = p.bg_dark },
    BufferLineNumbersVisible = { fg = p.fg_dim, bg = p.bg_dark },
    BufferLineNumbersSelected = { fg = p.pink, bg = p.bg },
    BufferLineOffsetSeparator = { fg = p.bg_highlight, bg = p.bg_darker },
  }
end

return { build = build }
```

- [ ] **Step 5: Write gitsigns.lua**

Write to `lua/synthwave3000/groups/plugins/gitsigns.lua`:

```lua
local function build(p, o)
  return {
    GitSignsAdd = { fg = p.green },
    GitSignsChange = { fg = p.yellow },
    GitSignsDelete = { fg = p.red },
    GitSignsTopdelete = { fg = p.red },
    GitSignsChangedelete = { fg = p.orange },
    GitSignsUntracked = { fg = p.comment },
    GitSignsAddNr = { fg = p.green },
    GitSignsChangeNr = { fg = p.yellow },
    GitSignsDeleteNr = { fg = p.red },
    GitSignsAddLn = { fg = p.green },
    GitSignsChangeLn = { fg = p.yellow },
    GitSignsDeleteLn = { fg = p.red },
    GitSignsAddInline = { fg = p.green },
    GitSignsChangeInline = { fg = p.yellow },
    GitSignsDeleteInline = { fg = p.red },
    GitSignsAddLnInline = { fg = p.green },
    GitSignsChangeLnInline = { fg = p.yellow },
    GitSignsDeleteLnInline = { fg = p.red },
    GitSignsAddPreview = { fg = p.green, bg = p.bg_highlight },
    GitSignsDeletePreview = { fg = p.red, bg = p.bg_highlight },
    GitSignsCurrentLineBlame = { fg = p.comment, italic = true },
    GitSignsAddVirtLn = { fg = p.green },
    GitSignsChangeVirtLn = { fg = p.yellow },
    GitSignsDeleteVirtLn = { fg = p.red },
    GitSignsStagedAdd = { fg = p.green },
    GitSignsStagedChange = { fg = p.yellow },
    GitSignsStagedDelete = { fg = p.red },
    GitSignsStagedTopdelete = { fg = p.red },
    GitSignsStagedChangedelete = { fg = p.orange },
  }
end

return { build = build }
```

- [ ] **Step 6: Write diffview.lua**

Write to `lua/synthwave3000/groups/plugins/diffview.lua`:

```lua
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
```

- [ ] **Step 7: Write nvim_cmp.lua**

Write to `lua/synthwave3000/groups/plugins/nvim_cmp.lua`:

```lua
local function build(p, o)
  return {
    CmpItemAbbr = { fg = p.fg },
    CmpItemAbbrDeprecated = { fg = p.fg_dim, strikethrough = true },
    CmpItemAbbrMatch = { fg = p.cyan, bold = true },
    CmpItemAbbrMatchFuzzy = { fg = p.cyan, bold = true },
    CmpItemMenu = { fg = p.fg_dim },
    CmpItemKindDefault = { fg = p.fg_dim },
    CmpItemKindText = { fg = p.orange_bright },
    CmpItemKindMethod = { fg = p.cyan },
    CmpItemKindFunction = { fg = p.cyan },
    CmpItemKindConstructor = { fg = p.yellow },
    CmpItemKindField = { fg = p.pink },
    CmpItemKindVariable = { fg = p.pink },
    CmpItemKindClass = { fg = p.red },
    CmpItemKindInterface = { fg = p.red },
    CmpItemKindModule = { fg = p.purple },
    CmpItemKindProperty = { fg = p.pink },
    CmpItemKindUnit = { fg = p.orange },
    CmpItemKindValue = { fg = p.orange },
    CmpItemKindEnum = { fg = p.red },
    CmpItemKindKeyword = { fg = p.yellow },
    CmpItemKindSnippet = { fg = p.orange },
    CmpItemKindColor = { fg = p.pink },
    CmpItemKindFile = { fg = p.cyan },
    CmpItemKindReference = { fg = p.pink },
    CmpItemKindFolder = { fg = p.cyan },
    CmpItemKindEnumMember = { fg = p.red },
    CmpItemKindConstant = { fg = p.orange },
    CmpItemKindStruct = { fg = p.red },
    CmpItemKindEvent = { fg = p.yellow },
    CmpItemKindOperator = { fg = p.yellow },
    CmpItemKindTypeParameter = { fg = p.red },
    CmpItemKindCopilot = { fg = p.green },
  }
end

return { build = build }
```

- [ ] **Step 8: Write blink_cmp.lua**

Write to `lua/synthwave3000/groups/plugins/blink_cmp.lua`:

```lua
local function build(p, o)
  return {
    BlinkCmpMenu = { fg = p.fg, bg = p.bg_panel },
    BlinkCmpMenuBorder = { fg = p.bg_highlight, bg = p.bg_panel },
    BlinkCmpMenuSelection = { fg = p.fg, bg = p.bg_highlight },
    BlinkCmpScrollBarThumb = { bg = p.selection },
    BlinkCmpScrollBarGutter = { bg = p.bg_panel },
    BlinkCmpLabel = { fg = p.fg },
    BlinkCmpLabelDeprecated = { fg = p.fg_dim, strikethrough = true },
    BlinkCmpLabelMatch = { fg = p.cyan, bold = true },
    BlinkCmpLabelDetail = { fg = p.fg_dim },
    BlinkCmpLabelDescription = { fg = p.fg_dim },
    BlinkCmpKind = { fg = p.fg_dim },
    BlinkCmpKindText = { fg = p.orange_bright },
    BlinkCmpKindMethod = { fg = p.cyan },
    BlinkCmpKindFunction = { fg = p.cyan },
    BlinkCmpKindConstructor = { fg = p.yellow },
    BlinkCmpKindField = { fg = p.pink },
    BlinkCmpKindVariable = { fg = p.pink },
    BlinkCmpKindClass = { fg = p.red },
    BlinkCmpKindInterface = { fg = p.red },
    BlinkCmpKindModule = { fg = p.purple },
    BlinkCmpKindProperty = { fg = p.pink },
    BlinkCmpKindUnit = { fg = p.orange },
    BlinkCmpKindValue = { fg = p.orange },
    BlinkCmpKindEnum = { fg = p.red },
    BlinkCmpKindKeyword = { fg = p.yellow },
    BlinkCmpKindSnippet = { fg = p.orange },
    BlinkCmpKindColor = { fg = p.pink },
    BlinkCmpKindFile = { fg = p.cyan },
    BlinkCmpKindReference = { fg = p.pink },
    BlinkCmpKindFolder = { fg = p.cyan },
    BlinkCmpKindEnumMember = { fg = p.red },
    BlinkCmpKindConstant = { fg = p.orange },
    BlinkCmpKindStruct = { fg = p.red },
    BlinkCmpKindEvent = { fg = p.yellow },
    BlinkCmpKindOperator = { fg = p.yellow },
    BlinkCmpKindTypeParameter = { fg = p.red },
    BlinkCmpSource = { fg = p.fg_dim },
    BlinkCmpGhostText = { fg = p.comment },
    BlinkCmpDoc = { fg = p.fg, bg = p.bg_panel },
    BlinkCmpDocBorder = { fg = p.bg_highlight, bg = p.bg_panel },
    BlinkCmpDocSeparator = { fg = p.bg_highlight },
    BlinkCmpDocCursorLine = { bg = p.bg_highlight },
    BlinkCmpSignatureHelp = { fg = p.fg, bg = p.bg_panel },
    BlinkCmpSignatureHelpBorder = { fg = p.bg_highlight, bg = p.bg_panel },
    BlinkCmpSignatureHelpActiveParameter = { fg = p.cyan, bold = true },
  }
end

return { build = build }
```

- [ ] **Step 9: Write mini.lua**

Write to `lua/synthwave3000/groups/plugins/mini.lua`:

```lua
local function build(p, o)
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
  }
end

return { build = build }
```

- [ ] **Step 10: Write indent_blankline.lua**

Write to `lua/synthwave3000/groups/plugins/indent_blankline.lua`:

```lua
local function build(p, o)
  return {
    IblIndent = { fg = p.bg_highlight },
    IblWhitespace = { fg = p.bg_highlight },
    IblScope = { fg = p.comment },
  }
end

return { build = build }
```

- [ ] **Step 11: Write which_key.lua**

Write to `lua/synthwave3000/groups/plugins/which_key.lua`:

```lua
local function build(p, o)
  return {
    WhichKey = { fg = p.pink, bold = true },
    WhichKeyGroup = { fg = p.cyan, bold = true },
    WhichKeyDesc = { fg = p.fg },
    WhichKeySeparator = { fg = p.fg_dim },
    WhichKeyFloat = { bg = p.bg_panel },
    WhichKeyBorder = { fg = p.bg_highlight, bg = p.bg_panel },
    WhichKeyValue = { fg = p.green },
  }
end

return { build = build }
```

- [ ] **Step 12: Write noice.lua**

Write to `lua/synthwave3000/groups/plugins/noice.lua`:

```lua
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
```

- [ ] **Step 13: Write notify.lua**

Write to `lua/synthwave3000/groups/plugins/notify.lua`:

```lua
local function build(p, o)
  return {
    NotifyERRORBorder = { fg = p.red },
    NotifyWARNBorder = { fg = p.yellow },
    NotifyINFOBorder = { fg = p.cyan },
    NotifyDEBUGBorder = { fg = p.comment },
    NotifyTRACEBorder = { fg = p.purple },
    NotifyERRORIcon = { fg = p.red },
    NotifyWARNIcon = { fg = p.yellow },
    NotifyINFOIcon = { fg = p.cyan },
    NotifyDEBUGIcon = { fg = p.comment },
    NotifyTRACEIcon = { fg = p.purple },
    NotifyERRORTitle = { fg = p.red, bold = true },
    NotifyWARNTitle = { fg = p.yellow, bold = true },
    NotifyINFOTitle = { fg = p.cyan, bold = true },
    NotifyDEBUGTitle = { fg = p.comment, bold = true },
    NotifyTRACETitle = { fg = p.purple, bold = true },
    NotifyERRORBody = { fg = p.fg },
    NotifyWARNBody = { fg = p.fg },
    NotifyINFOBody = { fg = p.fg },
    NotifyDEBUGBody = { fg = p.fg },
    NotifyTRACEBody = { fg = p.fg },
  }
end

return { build = build }
```

- [ ] **Step 14: Write trouble.lua**

Write to `lua/synthwave3000/groups/plugins/trouble.lua`:

```lua
local function build(p, o)
  return {
    TroubleNormal = { fg = p.fg, bg = p.bg_dark },
    TroubleText = { fg = p.fg },
    TroubleCount = { fg = p.pink, bold = true },
    TroubleNormalFloat = { fg = p.fg, bg = p.bg_dark },
    TroubleIndent = { fg = p.comment },
    TroubleFoldIcon = { fg = p.comment },
    TroubleLocation = { fg = p.cyan },
    TroubleSource = { fg = p.cyan, bold = true },
    TroubleCode = { fg = p.fg_dim },
  }
end

return { build = build }
```

- [ ] **Step 15: Write flash.lua**

Write to `lua/synthwave3000/groups/plugins/flash.lua`:

```lua
local function build(p, o)
  return {
    FlashBackdrop = { fg = p.fg_dim },
    FlashMatch = { fg = p.pink, bold = true },
    FlashCurrent = { fg = p.cyan, bold = true },
    FlashLabel = { fg = p.yellow, bold = true },
    FlashPrompt = { fg = p.fg, bg = p.bg_panel },
    FlashPromptIcon = { fg = p.cyan },
    FlashCursor = { fg = p.bg, bg = p.pink },
  }
end

return { build = build }
```

- [ ] **Step 16: Write snacks.lua**

Write to `lua/synthwave3000/groups/plugins/snacks.lua`:

```lua
local function build(p, o)
  return {
    SnacksNormal = { fg = p.fg, bg = p.bg_dark },
    SnacksNormalNC = { fg = p.fg, bg = p.bg_dark },
    SnacksWinBar = { fg = p.fg, bg = p.bg_dark },
    SnacksWinBarNC = { fg = p.fg_dim, bg = p.bg_darker },
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
    SnacksNotifierInfo = { fg = p.cyan },
    SnacksNotifierWarn = { fg = p.yellow },
    SnacksNotifierError = { fg = p.red },
    SnacksNotifierDebug = { fg = p.comment },
    SnacksNotifierTrace = { fg = p.purple },
    SnacksNotifierIconInfo = { fg = p.cyan },
    SnacksNotifierIconWarn = { fg = p.yellow },
    SnacksNotifierIconError = { fg = p.red },
    SnacksPickerBorder = { fg = p.bg_highlight },
    SnacksPickerInput = { fg = p.fg, bg = p.bg_panel },
    SnacksPickerList = { fg = p.fg, bg = p.bg },
    SnacksPickerPreview = { fg = p.fg, bg = p.bg },
    SnacksPickerMatch = { fg = p.cyan, bold = true },
    SnacksPickerSelected = { fg = p.pink, bold = true },
  }
end

return { build = build }
```

- [ ] **Step 17: Write lualine.lua**

Write to `lua/synthwave3000/groups/plugins/lualine.lua`:

```lua
local M = {}

function M.build(p, o)
  local function mode(fg, bg)
    return { a = { fg = fg, bg = bg, gui = "bold" }, b = { fg = p.fg, bg = p.bg_highlight }, c = { fg = p.fg, bg = p.bg_dark } }
  end

  return {
    normal = mode(p.bg, p.pink),
    insert = mode(p.bg, p.cyan),
    visual = mode(p.bg, p.purple),
    replace = mode(p.bg, p.orange),
    command = mode(p.bg, p.yellow),
    terminal = mode(p.bg, p.green),
    inactive = {
      a = { fg = p.fg_dim, bg = p.bg_darker, gui = "bold" },
      b = { fg = p.fg_dim, bg = p.bg_darker },
      c = { fg = p.fg_dim, bg = p.bg_darker },
    },
  }
end

return M
```

- [ ] **Step 18: Commit all plugin files**

```bash
git add lua/synthwave3000/groups/plugins/ && git commit -m "feat: add all plugin highlight groups (telescope, nvim-tree, neo-tree, bufferline, lualine, gitsigns, diffview, cmp, blink, mini, indent-blankline, which-key, noice, notify, trouble, flash, snacks)"
```

---

### Task 15: Implement tests

**Files:**
- Modify: `tests/minimal_init.lua`
- Modify: `tests/synthwave3000_spec.lua`

- [ ] **Step 1: Write tests/minimal_init.lua**

Write to `tests/minimal_init.lua`:

```lua
vim.opt.runtimepath:prepend(vim.fn.getcwd())
vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/lazy/plenary.nvim")
pcall(function()
  vim.cmd("runtime plugin/plenary.vim")
end)
require("synthwave3000").setup({})
vim.cmd.colorscheme("synthwave3000")
```

- [ ] **Step 2: Write tests/synthwave3000_spec.lua**

Write to `tests/synthwave3000_spec.lua`:

```lua
describe("synthwave3000", function()
  it("sets vim.g.colors_name", function()
    assert.equals("synthwave3000", vim.g.colors_name)
  end)

  it("defines Normal with fg and bg", function()
    local hl = vim.api.nvim_get_hl(0, { name = "Normal" })
    assert.is_not_nil(hl.fg)
    assert.is_not_nil(hl.bg)
  end)

  it("defines all required Tree-sitter groups", function()
    local groups = {
      "@variable", "@function", "@keyword", "@type",
      "@string", "@comment", "@markup.heading",
      "@markup.raw", "@markup.link.url",
    }
    for _, g in ipairs(groups) do
      local hl = vim.api.nvim_get_hl(0, { name = g })
      assert.is_true(next(hl) ~= nil, "missing group: " .. g)
    end
  end)

  it("defines Added/Changed/Removed (0.10 regression)", function()
    for _, g in ipairs({ "Added", "Changed", "Removed" }) do
      local hl = vim.api.nvim_get_hl(0, { name = g })
      assert.is_true(next(hl) ~= nil, "missing: " .. g)
    end
  end)

  it("WCAG AA on default dark bg", function()
    local C = require("synthwave3000.util").contrast
    local p = require("synthwave3000.palette").build({ style = "dark" })
    assert.is_true(C(p.pink, p.bg) >= 4.5)
    assert.is_true(C(p.cyan, p.bg) >= 4.5)
    assert.is_true(C(p.yellow, p.bg) >= 4.5)
    assert.is_true(C(p.green, p.bg) >= 4.5)
    assert.is_true(C(p.orange, p.bg) >= 4.5)
    assert.is_true(C(p.red, p.bg) >= 4.5)
    assert.is_true(C(p.comment, p.bg) >= 4.5)
  end)

  it("WCAG AA on default light bg", function()
    local C = require("synthwave3000.util").contrast
    local p = require("synthwave3000.palette").build({ style = "light" })
    assert.is_true(C(p.pink, p.bg) >= 4.5)
    assert.is_true(C(p.cyan, p.bg) >= 4.5)
    assert.is_true(C(p.yellow, p.bg) >= 4.5)
    assert.is_true(C(p.green, p.bg) >= 4.5)
    assert.is_true(C(p.orange, p.bg) >= 4.5)
    assert.is_true(C(p.red, p.bg) >= 4.5)
    assert.is_true(C(p.comment, p.bg) >= 4.5)
  end)

  it("light palette is returned when style=light", function()
    local p = require("synthwave3000.palette").build({ style = "light" })
    assert.equals("#f5f0ff", p.bg)
    assert.equals("#1a1a2e", p.fg)
  end)

  it("dark palette is returned when style=dark", function()
    local p = require("synthwave3000.palette").build({ style = "dark" })
    assert.equals("#262335", p.bg)
    assert.equals("#ffffff", p.fg)
  end)
end)
```

- [ ] **Step 3: Commit**

```bash
git add tests/ && git commit -m "test: add plenary-based tests for correctness and WCAG compliance"
```

---

### Task 16: Implement doc/synthwave3000.txt — Neovim help file

**Files:**
- Modify: `doc/synthwave3000.txt`

- [ ] **Step 1: Write help file**

Write to `doc/synthwave3000.txt`:

```txt
*synthwave3000.txt*    Synthwave '84-inspired colorscheme for Neovim

==============================================================================
CONTENTS                                                    *synthwave3000*

1. Introduction ................. |synthwave3000-introduction|
2. Installation ................. |synthwave3000-installation|
3. Usage ........................ |synthwave3000-usage|
4. Configuration ................ |synthwave3000-configuration|
5. Light & Dark Mode ............ |synthwave3000-light-dark|
6. Glow Effect .................. |synthwave3000-glow|
7. Plugin Support ............... |synthwave3000-plugins|
8. Customization ................ |synthwave3000-customization|

==============================================================================
INTRODUCTION                                    *synthwave3000-introduction*

synthwave3000.nvim is a Neovim colorscheme inspired by Robb Owen's Synthwave
'84 VS Code theme. It features:

- Dark mode with the canonical Synthwave '84 palette
- Light mode with an inverted variant
- WCAG AA contrast compliance on all backgrounds
- Full Neovim 0.10/0.11/0.12 compatibility
- Support for 17+ popular plugins
- Extensive customization options

==============================================================================
INSTALLATION                                        *synthwave3000-installation*

lazy.nvim (recommended)~
>lua
  {
    "Web-Dev-Codi/synthwave3000.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts)
      require("synthwave3000").setup(opts)
      vim.cmd.colorscheme("synthwave3000")
    end,
  }
<

packer.nvim~
>lua
  use {
    "Web-Dev-Codi/synthwave3000.nvim",
    config = function()
      require("synthwave3000").setup({})
      vim.cmd.colorscheme("synthwave3000")
    end,
  }
<

vim-plug~
>vim
  Plug 'Web-Dev-Codi/synthwave3000.nvim'
  " After plug#end():
  lua require("synthwave3000").setup({}); vim.cmd.colorscheme("synthwave3000")
<

==============================================================================
USAGE                                                      *synthwave3000-usage*

The minimal setup:
>lua
  require("synthwave3000").setup()
  vim.cmd.colorscheme("synthwave3000")
<

==============================================================================
CONFIGURATION                                      *synthwave3000-configuration*

>lua
  require("synthwave3000").setup({
    style = "auto",              -- "dark" | "light" | "auto"
    transparent = false,         -- transparent background
    terminal_colors = true,      -- set terminal colors
    styles = {
      comments = { italic = true },
      keywords = { bold = true },
      functions = { bold = true },
      variables = {},
      strings = {},
      types = { bold = true },
      operators = {},
    },
    glow = {
      enabled = true,
      brighten = 0.10,
      background = false,
    },
    plugins = {
      telescope = true,
      nvim_tree = true,
      neo_tree = true,
      bufferline = true,
      lualine = true,
      gitsigns = true,
      diffview = true,
      cmp = true,
      blink_cmp = true,
      mini = true,
      indent_blankline = true,
      which_key = true,
      noice = true,
      notify = true,
      trouble = true,
      flash = true,
      snacks = true,
    },
    on_colors = function(colors) end,
    on_highlights = function(highlights, colors) end,
  })
<

==============================================================================
LIGHT & DARK MODE                                  *synthwave3000-light-dark*

Set |synthwave3000-style| to "auto" and the colorscheme follows
|vim.o.background|. Set to "dark" or "light" to lock one mode.

The glow effect auto-disables in light mode.

==============================================================================
GLOW EFFECT                                               *synthwave3000-glow*

The "glow" effect is an approximation of the VS Code Synthwave '84 CSS
text-shadow. In a terminal, glow is simulated via bold + brightened
foreground colors. Optionally, a faint background halo can be enabled.

>lua
  glow = {
    enabled = true,
    groups = { "Function", "Keyword", "Type", "@function", "@keyword", "@type" },
    bold = true,
    brighten = 0.10,
    background = false,  -- faint bg halo
    bg_blend = 0.06,
  }
<

Glow is auto-disabled in light mode.

==============================================================================
PLUGIN SUPPORT                                         *synthwave3000-plugins*

Supported plugins (toggle via opts.plugins):
- telescope.nvim
- nvim-tree.lua
- neo-tree.nvim
- bufferline.nvim
- lualine.nvim (theme at lua/lualine/themes/synthwave3000.lua)
- gitsigns.nvim
- diffview.nvim
- nvim-cmp
- blink.cmp
- mini.nvim
- indent-blankline.nvim
- which-key.nvim
- noice.nvim
- nvim-notify
- trouble.nvim
- flash.nvim
- snacks.nvim

==============================================================================
CUSTOMIZATION                                        *synthwave3000-customization*

Override any highlight group via |on_highlights|:
>lua
  on_highlights = function(hl, c)
    hl.Comment = { fg = c.comment, italic = false }
    hl.Normal = { fg = c.fg, bg = "#000000" }
  end
<

Override any color via |on_colors|:
>lua
  on_colors = function(c)
    c.pink = "#ff69b4"
  end
<

 vim:tw=78:ts=8:ft=help:norl:
```

- [ ] **Step 2: Commit**

```bash
git add doc/synthwave3000.txt && git commit -m "docs: add Neovim help file"
```

---

### Task 17: Write README.md

**Files:**
- Create: `README.md`

- [ ] **Step 1: Write README.md**

Write to `README.md`:

```markdown
# synthwave3000.nvim

A Neovim colorscheme inspired by Robb Owen's [Synthwave '84](https://github.com/robb0wen/synthwave-vscode) VS Code theme.

Dark mode with the canonical Synthwave '84 palette + light mode with an inverted variant. WCAG AA compliant. 17+ plugin integrations.

![Dark mode preview](https://via.placeholder.com/800x400/262335/ff7edb?text=Dark+Mode)
![Light mode preview](https://via.placeholder.com/800x400/f5f0ff/1a1a2e?text=Light+Mode)

## Features

- Dark + Light mode with `style = "auto" | "dark" | "light"`
- Synthwave "glow" effect approximation (bold + brightened fg)
- WCAG AA contrast (≥4.5:1) on all backgrounds
- Neovim 0.10/0.11/0.12 compatible
- 17+ plugin integrations
- Fully customizable via `on_colors` and `on_highlights`

## Installation

**lazy.nvim:**
```lua
{
  "Web-Dev-Codi/synthwave3000.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function(_, opts)
    require("synthwave3000").setup(opts)
    vim.cmd.colorscheme("synthwave3000")
  end,
}
```

**packer.nvim:**
```lua
use {
  "Web-Dev-Codi/synthwave3000.nvim",
  config = function()
    require("synthwave3000").setup({})
    vim.cmd.colorscheme("synthwave3000")
  end,
}
```

**vim-plug:**
```vim
Plug 'Web-Dev-Codi/synthwave3000.nvim'
" After plug#end():
lua require("synthwave3000").setup({}); vim.cmd.colorscheme("synthwave3000")
```

## Usage

```lua
require("synthwave3000").setup({
  style = "auto",     -- "dark" | "light" | "auto"
  transparent = false,
  glow = { enabled = true },
})
vim.cmd.colorscheme("synthwave3000")
```

## Configuration

| Option | Default | Description |
|--------|---------|-------------|
| `style` | `"auto"` | Color scheme style: `"dark"`, `"light"`, or `"auto"` (follows `vim.o.background`) |
| `transparent` | `false` | Use transparent backgrounds for Normal, sidebar, etc. |
| `terminal_colors` | `true` | Set terminal ANSI colors |
| `glow.enabled` | `true` | Enable Synthwave glow effect (auto-disables in light mode) |
| `glow.brighten` | `0.10` | HSLuv lightness boost for glow groups |
| `glow.background` | `false` | Faint background halo for glow groups |

### Styles

Control per-category styling:

```lua
styles = {
  comments  = { italic = true },
  keywords  = { bold = true },
  functions = { bold = true },
  variables = {},
  strings   = {},
  types     = { bold = true },
  operators = {},
}
```

### Plugin Toggle

Disable plugins you don't use:

```lua
plugins = {
  telescope = true, nvim_tree = true, neo_tree = true,
  bufferline = true, lualine = true, gitsigns = true,
  diffview = true, cmp = true, blink_cmp = true,
  mini = true, indent_blankline = true, which_key = true,
  noice = true, notify = true, trouble = true,
  flash = true, snacks = true,
}
```

### Customization

Override colors:
```lua
on_colors = function(c)
  c.pink = "#ff69b4"
end
```

Override highlights:
```lua
on_highlights = function(hl, c)
  hl.Comment = { fg = c.comment, italic = false }
end
```

## Supported Plugins

telescope.nvim, nvim-tree.lua, neo-tree.nvim, bufferline.nvim, lualine.nvim, gitsigns.nvim, diffview.nvim, nvim-cmp, blink.cmp, mini.nvim, indent-blankline.nvim, which-key.nvim, noice.nvim, nvim-notify, trouble.nvim, flash.nvim, snacks.nvim

## Light Mode

Set `style = "light"` or `style = "auto"` with `vim.o.background = "light"`. The glow effect is auto-disabled in light mode.

## About the Glow

The original VS Code Synthwave '84 glow is a CSS `text-shadow` injected via custom CSS extension. Terminals cannot render text-shadow. The glow effect here is an approximation using:
1. Bold text + brightened HSLuv foreground colors for keywords/functions/types
2. Optional faint background blending (6% opacity)

This is documented as an approximation — it will not look identical to the VS Code version.

## Testing

```bash
nvim --headless -u tests/minimal_init.lua -c "PlenaryBustedFile tests/synthwave3000_spec.lua"
```

## License

MIT
```

- [ ] **Step 2: Commit**

```bash
git add README.md && git commit -m "docs: add README"
```

---

### Task 18: Write LICENSE (MIT)

**Files:**
- Create: `LICENSE`

- [ ] **Step 1: Write LICENSE**

Write to `LICENSE`:

```txt
MIT License

Copyright (c) 2026 Web-Dev-Codi

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

- [ ] **Step 2: Commit**

```bash
git add LICENSE && git commit -m "docs: add MIT license"
```
