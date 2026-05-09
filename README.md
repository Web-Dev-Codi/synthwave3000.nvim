# synthwave3000.nvim

A Neovim colorscheme inspired by Robb Owen's [Synthwave '84](https://github.com/robb0wen/synthwave-vscode) VS Code theme.

Dark mode with the canonical Synthwave '84 palette + light mode with an inverted variant. WCAG AA compliant. 21 plugin integrations. All structural borders use the theme's signature pink.

## Features

- Dark + Light mode with `style = "auto" | "dark" | "light"`
- Synthwave "glow" effect approximation (bold + HSL-brightened foreground on keywords/functions/types)
- Transparent background support — affects Normal, sidebars, floats, and statusline section C
- WCAG AA contrast (>=4.5:1) on all backgrounds
- Neovim 0.10/0.11/0.12 compatible
- 21 plugin integrations with per-plugin toggles
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
  style = "auto",
  transparent = false,
  glow = { enabled = true },
})
vim.cmd.colorscheme("synthwave3000")
```

## Configuration

### Top-Level Options

| Option | Default | Description |
|--------|---------|-------------|
| `style` | `"auto"` | `"dark"`, `"light"`, or `"auto"` (follows `vim.o.background`) |
| `transparent` | `false` | Transparent backgrounds for Normal, sidebars, floats, and statusline section C |
| `background` | `nil` | Override the Normal background color (nil = use palette default) |
| `terminal_colors` | `true` | Set terminal ANSI color palette |
| `glow.enabled` | `true` | Synthwave glow — brightens fg + applies bold to keywords/functions/types |
| `glow.brighten` | `0.10` | HSL lightness boost factor for glow groups |
| `glow.bold` | `true` | Apply bold styling to glow groups |
| `on_colors` | `nil` | `function(palette)` — mutate the palette before highlight generation |
| `on_highlights` | `nil` | `function(groups, palette)` — override highlight groups directly |

### Styles

```lua
styles = {
  comments = { italic = true },
  keywords = { bold = true },
  functions = { bold = true },
  variables = {},
  strings = {},
  types = { bold = true },
  operators = {},
}
```

| Sub-key | Default | Description |
|---------|---------|-------------|
| `comments` | `{ italic = true }` | Comment style |
| `keywords` | `{ bold = true }` | Keyword style |
| `functions` | `{ bold = true }` | Function/method style |
| `variables` | `{}` | Variable style |
| `strings` | `{}` | String literal style |
| `types` | `{ bold = true }` | Type/class style |
| `operators` | `{}` | Operator style |

### Plugin Toggle

Each plugin integration can be independently enabled or disabled:

```lua
plugins = {
  telescope = true, nvim_tree = true, neo_tree = true,
  bufferline = true, lualine = true, gitsigns = true,
  diffview = true, cmp = true, blink_cmp = true,
  mini = true, indent_blankline = true, which_key = true,
  noice = true, notify = true, trouble = true,
  flash = true, snacks = true, dashboard = true,
  aerial = true, dap = true, neogit = true,
  render_markdown = true,
}
```

### Customization

```lua
on_colors = function(c)
  c.pink = "#ff69b4"
end

on_highlights = function(hl, c)
  hl.Comment = { fg = c.comment, italic = false }
end
```

## Palette

### Dark Mode

| Key | Hex | Description |
|-----|-----|-------------|
| `bg` | `#262335` | Main background |
| `bg_dark` | `#0D0221` | Sidebar / float / statusline background |
| `bg_darker` | `#171520` | Statusline inactive / tabline fill |
| `bg_panel` | `#2a2139` | Popup menu background |
| `bg_highlight` | `#34294f` | Cursor line / color column |
| `bg_visual` | `#413f4e` | Visual selection |
| `fg` | `#ffffff` | Primary foreground |
| `fg_dim` | `#b6b1b1` | Dimmed / inactive text |
| `comment` | `#848bbd` | Comments |
| `pink` | `#FF00FF` | Accent — borders, titles, selection |
| `cyan` | `#00FFFF` | Strings, special values, links |
| `green` | `#33FF33` | Added / success / git staged |
| `yellow` | `#fede5d` | Warnings / changed / modified |
| `orange` | `#f97e72` | Unsaved changes / operators |
| `orange_bright` | `#ff8b39` | Bright orange accent |
| `red` | `#fe4450` | Errors / deleted / removed |
| `purple` | `#8C1EFF` | Keywords / special identifiers |
| `blue` | `#03edf9` | Blue accent |
| `selection` | `#463465` | Selection / scrollbar thumb |
| `none` | `"NONE"` | Transparent sentinel |

### Light Mode

| Key | Hex | Description |
|-----|-----|-------------|
| `bg` | `#f5f0ff` | Main background |
| `bg_dark` | `#e8e0f0` | Sidebar / float / statusline background |
| `bg_darker` | `#ddd4e8` | Statusline inactive / tabline fill |
| `bg_panel` | `#f0ebf8` | Popup menu background |
| `bg_highlight` | `#ddd4e8` | Cursor line / color column |
| `bg_visual` | `#dad5e5` | Visual selection |
| `fg` | `#1a1a2e` | Primary foreground |
| `fg_dim` | `#5a5a7a` | Dimmed / inactive text |
| `comment` | `#7c7fa0` | Comments |
| `pink` | `#c445a3` | Accent — borders, titles, selection |
| `cyan` | `#007777` | Strings, special values, links |
| `green` | `#2d8f5e` | Added / success / git staged |
| `yellow` | `#b0901f` | Warnings / changed / modified |
| `orange` | `#c0552a` | Unsaved changes / operators |
| `orange_bright` | `#d4652a` | Bright orange accent |
| `red` | `#c62828` | Errors / deleted / removed |
| `purple` | `#7c5295` | Keywords / special identifiers |
| `blue` | `#0288d1` | Blue accent |
| `selection` | `#d0c0e8` | Selection / scrollbar thumb |
| `none` | `"NONE"` | Transparent sentinel |

## Glow Effect

The "glow" effect is an approximation of the VS Code Synthwave '84 CSS `text-shadow`. Since Neovim renders text via a cell-based terminal grid — not a GPU compositing pipeline — true glow/bloom is not possible. Instead:

- **Foreground brightening**: `util.brighten(color, amount)` boosts the HSL lightness of `Keyword`, `Function`, `Type`, and their treesitter equivalents by `glow.brighten` (default 0.10).
- **Bold**: Groups with glow get `bold = true` by default.

Glow is **auto-disabled in light mode** (`style = "light"` or `vim.o.background == "light"`) because brightened colors against a light background would lose contrast.

## Supported Plugins

| Plugin | Toggle Key | Highlights |
|--------|-----------|------------|
| telescope.nvim | `plugins.telescope` | 40+ groups — picker borders, results, prompt |
| nvim-tree.lua | `plugins.nvim_tree` | 40+ groups — file tree, git icons |
| neo-tree.nvim | `plugins.neo_tree` | Float border, normal, indent markers |
| bufferline.nvim | `plugins.bufferline` | 40+ groups — tabs, separators, diagnostics, modified |
| lualine.nvim | `plugins.lualine` | Theme table — all modes, inactive |
| gitsigns.nvim | `plugins.gitsigns` | Sign column, diff hunks |
| diffview.nvim | `plugins.diffview` | Diff panel backgrounds |
| nvim-cmp | `plugins.cmp` | Completion menu, documentation |
| blink.cmp | `plugins.blink_cmp` | 40+ groups — menu, docs, signature help |
| mini.nvim | `plugins.mini` | 80+ groups — pickers, statusline, files, diff, starter |
| indent-blankline.nvim | `plugins.indent_blankline` | Indent guides, scope |
| which-key.nvim | `plugins.which_key` | Popup, groups, descriptions |
| noice.nvim | `plugins.noice` | Cmdline popup, confirm, lsp progress |
| nvim-notify | `plugins.notify` | Notification borders (severity-colored) |
| trouble.nvim | `plugins.trouble` | Diagnostic list backgrounds |
| flash.nvim | `plugins.flash` | No custom groups (uses theme defaults) |
| snacks.nvim | `plugins.snacks` | 100+ groups — picker, dashboard, indent, notifier |
| dashboard-nvim | `plugins.dashboard` | Dashboard text, keys, footer |
| aerial.nvim | `plugins.aerial` | Symbol outline, float border |
| nvim-dap / nvim-dap-ui | `plugins.dap` | Debugger UI float border |
| neogit | `plugins.neogit` | Git status buffer |
| render-markdown.nvim | `plugins.render_markdown` | Headings, code blocks, links, checkboxes |

## Transparency

When `transparent = true`:

| Element | Behavior |
|---------|----------|
| `Normal`, `NormalNC` | `bg = "NONE"` |
| `NormalFloat`, sidebars (`SignColumn`, `FoldColumn`) | `bg = "NONE"` |
| `StatusLine`, `WinBar`, `TabLine` section C | `bg = "NONE"` |
| `Pmenu`, floating windows | Use palette `bg_panel` (keeps readability) |
| Bufferline section A, B | Keep colored backgrounds for visual distinction |
| Statusline section A (mode indicator) | Keep colored background |

Border colors are not affected by transparency — they remain `pink` regardless.

## Testing

```bash
nvim --headless -u tests/minimal_init.lua -c "PlenaryBustedFile tests/synthwave3000_spec.lua"
```

## License

MIT
