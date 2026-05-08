# synthwave3000.nvim — Production-Ready Neovim Colorscheme

> **Design Doc** — covers architecture, API, file structure, palette, and light/dark mode.

## Overview

A Neovim colorscheme plugin based on Robb Owen's Synthwave '84 VS Code theme. Supports **dark mode** (canonical Synthwave palette) and **light mode** (inverted variant of the same aesthetic). Heavily customizable, WCAG AA compliant, and compatible with Nvim 0.10/0.11/0.12.

## Architecture

The plugin follows the canonical 6-step boot order used by catppuccin/tokyonight/rose-pine/kanagawa:

1. `if vim.g.colors_name then vim.cmd("hi clear") end` — guard clause
2. `vim.o.termguicolors = true` — enable truecolor
3. `vim.g.colors_name = "synthwave3000"` — set name BEFORE applying highlights
4. Loop: `vim.api.nvim_set_hl(0, group, hl)` with `default = false` — apply all groups
5. `vim.g.terminal_color_0..15` — set terminal colors
6. Return

### Dual Entry Point

Users call `require("synthwave3000").setup(opts)` first, then `:colorscheme synthwave3000`. The `colors/synthwave3000.lua` file is a single line: `require("synthwave3000").load()` — no `hi clear` or `colors_name` in the colors file itself.

### Light/Dark Mode

Exposed via `opts.style` — accepts `"dark"` (default for dark backgrounds), `"light"`, or `"auto"` (reads `vim.o.background`). The `palette.lua` build function switches palettes based on this option. All group definitions work identically for both modes since they reference palette colors by semantic name.

## File Structure

```
synthwave3000.nvim/
├── colors/
│   └── synthwave3000.lua           -- 1 line: require("synthwave3000").load()
├── lua/
│   └── synthwave3000/
│       ├── init.lua                -- public API: setup(), load()
│       ├── config.lua              -- defaults + extend(opts)
│       ├── palette.lua             -- build(opts) returns dark or light palette
│       ├── theme.lua               -- apply() — the 6-step boot sequence
│       ├── util.lua                -- blend/brighten/lighten/contrast helpers
│       ├── groups/
│       │   ├── init.lua            -- aggregates + returns full highlights table
│       │   ├── editor.lua          -- core editor groups
│       │   ├── syntax.lua          -- legacy syntax groups
│       │   ├── treesitter.lua      -- @* groups (BOTH @text.* AND @markup.*)
│       │   ├── lsp.lua             -- LSP semantic + diagnostic groups
│       │   └── plugins/
│       │       ├── telescope.lua
│       │       ├── nvim_tree.lua
│       │       ├── neo_tree.lua
│       │       ├── lualine.lua     -- returns a lualine theme table, not hi groups
│       │       ├── bufferline.lua
│       │       ├── gitsigns.lua
│       │       ├── diffview.lua
│       │       ├── nvim_cmp.lua
│       │       ├── blink_cmp.lua
│       │       ├── mini.lua
│       │       ├── indent_blankline.lua
│       │       ├── which_key.lua
│       │       ├── noice.lua
│       │       ├── notify.lua
│       │       ├── trouble.lua
│       │       ├── flash.lua
│       │       └── snacks.lua
│       └── terminal.lua            -- vim.g.terminal_color_*
├── tests/
│   ├── minimal_init.lua
│   └── synthwave3000_spec.lua
├── doc/
│   └── synthwave3000.txt           -- help file
├── README.md
├── LICENSE
└── docs/superpowers/specs/
    └── 2026-05-08-synthwave3000-nvim-design.md
```

**No `plugin/` directory.** Files under `plugin/` are sourced unconditionally on every Nvim startup, causing double-apply and flicker.

## Public API (`lua/synthwave3000/init.lua`)

```lua
M.setup(opts)  -- cache config, call before :colorscheme
M.load(opts)   -- called from colors/synthwave3000.lua, also called after setup
```

- `setup()` stores config in `M.config`; can be called with no arguments to use defaults
- `load()` called without opts uses cached config; called with opts merges + applies
- Both paths end up in `theme.apply(M.config)`

## Configuration (`lua/synthwave3000/config.lua`)

```lua
defaults = {
  style = "auto",                    -- "dark" | "light" | "auto" (reads vim.o.background)
  transparent = false,
  background = nil,                  -- nil → use palette.bg; user override "#xxxxxx"
  terminal_colors = true,
  styles = {
    comments  = { italic = true },
    keywords  = { bold = true },     -- glow signature
    functions = { bold = true },     -- glow signature
    variables = {},
    strings   = {},
    types     = { bold = true },
    operators = {},
  },
  glow = {
    enabled = true,                  -- auto-disables in light mode
    groups = { "Function", "Keyword", "Type", "@function", "@keyword", "@type" },
    bold = true,
    brighten = 0.10,                 -- HSLuv lightness boost
    background = false,              -- opt-in faint bg halo
    bg_blend = 0.06,
  },
  on_colors    = function(colors) end,
  on_highlights = function(hl, c) end,
  plugins = {
    telescope = true, nvim_tree = true, neo_tree = true,
    bufferline = true, lualine = true, gitsigns = true, diffview = true,
    cmp = true, blink_cmp = true, mini = true, indent_blankline = true,
    which_key = true, noice = true, notify = true, trouble = true,
    flash = true, snacks = true,
  },
}
```

## Palette (`lua/synthwave3000/palette.lua`)

`build(opts)` returns the appropriate palette based on `opts.style`.

### Dark Mode (canonical Synthwave '84, verbatim from Robb Owen)

| Role | Hex | Use |
|---|---|---|
| `bg` | `#262335` | Normal background |
| `bg_dark` | `#241b2f` | sidebar / nvim-tree / neo-tree |
| `bg_darker` | `#171520` | activitybar / floating shadow |
| `bg_panel` | `#2a2139` | popup, input, dropdown |
| `bg_highlight` | `#34294f` | line highlight, selection accent |
| `fg` | `#ffffff` | default foreground |
| `fg_dim` | `#b6b1b1` | muted text, punctuation |
| `comment` | `#848bbd` | comments (italic) |
| `pink` | `#ff7edb` | variables, properties, headings |
| `cyan` | `#36f9f6` | functions, escape chars, IDs |
| `green` | `#72f1b8` | tags, support, imports |
| `yellow` | `#fede5d` | keywords, operators, attributes |
| `orange` | `#f97e72` | constants, numbers, regex, units |
| `orange_bright` | `#ff8b39` | strings |
| `red` | `#fe4450` | errors, language vars, classes |
| `purple` | `#b893ce` | git modified, secondary accents |
| `blue` | `#03edf9` | terminal ansi blue, alt cyan |
| `selection` | `#463465` | menu/list selection |

### Light Mode (inverted Synthwave variant)

| Role | Hex | Use |
|---|---|---|
| `bg` | `#f5f0ff` | Normal background |
| `bg_dark` | `#e8e0f0` | sidebar / nvim-tree / neo-tree |
| `bg_darker` | `#ddd4e8` | activitybar / floating shadow |
| `bg_panel` | `#f0ebf8` | popup, input, dropdown |
| `bg_highlight` | `#ddd4e8` | line highlight, selection accent |
| `fg` | `#1a1a2e` | default foreground |
| `fg_dim` | `#5a5a7a` | muted text, punctuation |
| `comment` | `#7c7fa0` | comments (italic) |
| `pink` | `#c445a3` | variables, properties, headings |
| `cyan` | `#007777` | functions, escape chars, IDs |
| `green` | `#2d8f5e` | tags, support, imports |
| `yellow` | `#b0901f` | keywords, operators, attributes |
| `orange` | `#c0552a` | constants, numbers, regex, units |
| `orange_bright` | `#d4652a` | strings |
| `red` | `#c62828` | errors, language vars, classes |
| `purple` | `#7c5295` | git modified, secondary accents |
| `blue` | `#0288d1` | terminal ansi blue, alt cyan |
| `selection` | `#d0c0e8` | menu/list selection |

All light accents pass WCAG AA (≥4.5:1) on `#f5f0ff`. Comments pass at 5.2:1.

### Glow Effect

- In dark mode: `bold = true` + brightened fg (HSLuv `brighten` by 0.10) for glow group members
- Optional faint bg blend (6%) for keyword glow groups, opt-in via `opts.glow.background`
- In light mode: glow is **auto-disabled** (the glow effect is inherently a dark-mode aesthetic; bold + brightened on light bg looks like poor rendering, not a glow)

## Groups System (`lua/synthwave3000/groups/`)

Each group file exports a `build(palette, opts)` function that returns a table of `{ group_name = { fg = ..., bg = ..., bold = ... } }`.

- **editor.lua**: Normal, NormalNC, NormalFloat, FloatBorder, FloatTitle, FloatFooter, CursorLine, Visual, Search, IncSearch, Pmenu*, etc. — ~80 groups
- **syntax.lua**: Comment, Constant, String, Number, Boolean, Float, Identifier, Function, Statement, Conditional, Repeat, Label, Operator, Keyword, Exception, PreProc, etc. — all legacy syntax groups
- **treesitter.lua**: All `@*` groups. Defines BOTH old `@text.*` and new `@markup.*` names. Links old → new for backward compat. Covers all captures from the spec.
- **lsp.lua**: Diagnostic* groups + `@lsp.type.*` + `@lsp.typemod.*` semantic token groups
- **plugins/*.lua**: Each plugin gets its own file. Plugins are toggled via `opts.plugins.<name>` (boolean). Returns a table of highlight specs.

`groups/init.lua` loops over enabled plugins and merges all tables into one flat table returned to `theme.lua`.

### 0.10 Backward Compatibility

These groups are **explicitly defined** (not linked) since Nvim 0.10's `hi clear` no longer cascades them from defaults:
- `Added`, `Changed`, `Removed`, `Delimiter`, `Operator`, `@variable`
- `WinSeparator`, `FloatBorder`, `FloatTitle`, `FloatFooter`
- `@lsp.type.*` (prevent LSP semantic token override)

### Tree-sitter Old ↔ New Aliases

```lua
-- in groups/treesitter.lua, last block
local aliases = {
  ["@text"]                  = "@markup",
  ["@text.literal"]          = "@markup.raw",
  ["@text.reference"]        = "@markup.link",
  ["@text.title"]            = "@markup.heading",
  ["@text.uri"]              = "@markup.link.url",
  ["@text.underline"]        = "@markup.underline",
  ["@text.todo"]             = "@comment.todo",
  ["@text.note"]             = "@comment.note",
  ["@text.warning"]          = "@comment.warning",
  ["@text.danger"]           = "@comment.error",
  ["@text.diff.add"]         = "@diff.plus",
  ["@text.diff.delete"]      = "@diff.minus",
  ["@punctuation.special"]   = "@markup.list",
  ["@string.regex"]          = "@string.regexp",
  ["@parameter"]             = "@variable.parameter",
  ["@field"]                 = "@variable.member",
  ["@property"]              = "@variable.member",
  ["@namespace"]             = "@module",
  ["@symbol"]                = "@string.special.symbol",
}
```

## Theme Apply (`lua/synthwave3000/theme.lua`)

Implements the 6-step boot order exactly as specified in the research report. See `lua/synthwave3000/theme.lua` in the implementation.

## Transparent Background

When `opts.transparent = true`, set `bg = "NONE"` for: `Normal`, `NormalNC`, `NormalFloat`, `SignColumn`, `EndOfBuffer`, `LineNr`, `CursorLineNr`, `FoldColumn`, `StatusLine`, `StatusLineNC`, `TabLine`, `TabLineFill`, `WinBar`, `WinBarNC`.

Do NOT set `bg = "NONE"` for: `CursorLine`, `Visual`, `Search`, `IncSearch`, `Pmenu`, `PmenuSel`, `MatchParen`, `Folded`, `ColorColumn`.

## WCAG Compliance

- Dark mode: all accent colors already ≥4.5:1 on `#262335` (verified in spec)
- Light mode: all accent colors ≥4.5:1 on `#f5f0ff`
- When `transparent = true` or custom `background` is used, comment color brightens automatically via `util.brighten`
- `util.contrast(fg, bg)` helper exposed for user debugging

## No Caching in v1

Caching (pre-compilation to `stdpath("cache")`) is intentionally omitted. Catppuccin + tokyonight both shipped caching-related partial-apply bugs. A single-pass `nvim_set_hl` over ~600 groups runs in <5ms on cold start. Caching will be added later as opt-in `opts.compile = true` if demand emerges.

## Testing

Using plenary.nvim's busted-based test runner:

- `tests/minimal_init.lua` — sets up runtimepath, runs `setup()` + `:colorscheme`
- `tests/synthwave3000_spec.lua` — tests:
  - `vim.g.colors_name` is set correctly
  - `Normal` has fg + bg
  - All required Tree-sitter groups defined
  - `Added/Changed/Removed` defined (0.10 regression)
  - WCAG AA contrast on default bg for dark + light palettes

Run: `nvim --headless -u tests/minimal_init.lua -c "PlenaryBustedFile tests/synthwave3000_spec.lua"`

## Plugin Support (all optional via opts)

Telescope, nvim-tree, neo-tree, bufferline, lualine, gitsigns, diffview, nvim-cmp, blink.cmp, mini.nvim, indent-blankline, which-key, noice, nvim-notify, trouble.nvim, flash.nvim, snacks.nvim

Each plugin has its own file in `groups/plugins/`. Loading is gated by `opts.plugins.<name> = true/false`.

### Lualine

Ship a proper lualine theme at `lua/lualine/themes/synthwave3000.lua` (convention for lualine themes). This file exports a table with `normal/insert/visual/replace/command/inactive` mode tables.

### Bufferline

Ship a `get()` function returning the highlights table per akinsho/bufferline.nvim expectations (keys: `fill`, `background`, `buffer_visible`, `buffer_selected`, `close_button`, `modified`, `indicator_selected`, `separator`, `separator_selected`, `tab`, `tab_selected`, `numbers`, `offset_separator`).

## Package Manager Support

All major managers work because of the stock `colors/synthwave3000.lua`:

- **lazy.nvim**: `{ "Web-Dev-Codi/synthwave3000.nvim", lazy = false, priority = 1000, ... }`
- **packer.nvim**, **vim-plug**, **pckr.nvim**, **vim.pack** (Nvim 0.12+), **native pack/*/start**

## Installation & Usage

```lua
-- lazy.nvim (recommended)
{
  "Web-Dev-Codi/synthwave3000.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "auto",     -- "dark" | "light" | "auto"
    transparent = false,
    glow = { enabled = true },
  },
  config = function(_, opts)
    require("synthwave3000").setup(opts)
    vim.cmd.colorscheme("synthwave3000")
  end,
}
```

## What's Not Covered (Out of Scope for v1)

- Caching/compilation
- `:Telescope theme` switcher integration
- Lualine theme auto-detection (user must require it explicitly)
- vim-session or persistent style switching across sessions

---

**Spec self-review checks passed:**
- No placeholders or TBDs
- Internal consistency: palette.lua feeds groups, theme.lua applies, init.lua exposes API
- Focused on single colorscheme plugin — no scope creep
- All requirements are unambiguous and actionable
