<div align="center">
  <img src="https://placehold.co/180x180/262335/ff00ff?text=S3K&font=source-sans-pro" width="180" alt="synthwave3000.nvim">
  <h1>synthwave3000.nvim</h1>
  <p><i>Neon dreams. Real contrast ratios.</i></p>
</div>

<p align="center">
  <a href="https://github.com/Web-Dev-Codi/synthwave3000.nvim/stargazers">
    <img src="https://img.shields.io/github/stars/Web-Dev-Codi/synthwave3000.nvim?style=for-the-badge&logo=starship&color=ff00ff&logoColor=ff00ff&labelColor=262335">
  </a>
  <a href="https://github.com/Web-Dev-Codi/synthwave3000.nvim/issues">
    <img src="https://img.shields.io/github/issues/Web-Dev-Codi/synthwave3000.nvim?style=for-the-badge&logo=gitbook&color=00ffff&logoColor=00ffff&labelColor=262335">
  </a>
  <a href="https://github.com/Web-Dev-Codi/synthwave3000.nvim/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/Web-Dev-Codi/synthwave3000.nvim?style=for-the-badge&color=33ff33&logoColor=33ff33&labelColor=262335">
  </a>
  <img src="https://img.shields.io/badge/Neovim-0.10+-fede5d.svg?style=for-the-badge&logo=neovim&logoColor=fede5d&labelColor=262335">
  <img src="https://img.shields.io/badge/Made_with-Lua-fe4450.svg?style=for-the-badge&logo=lua&logoColor=fe4450&labelColor=262335">
  <img src="https://img.shields.io/badge/WCAG_AA-AAA-f97e72.svg?style=for-the-badge&logo=accessibility&logoColor=f97e72&labelColor=262335">
</p>

<br>

<img src="https://placehold.co/800x450/262335/ffffff?text=synthwave3000+Dark+Mode&font=source-sans-pro" width="100%" alt="synthwave3000 dark mode preview">

---

## ✨ Features

- ♿ **WCAG AAA on dark, AA on light** — every accent verified against its background
- 🌗 **First-class light mode** — not an afterthought; same hue families, recalibrated lightness
- ⚡ **One-line install, zero required config** — `colorscheme synthwave3000` and you're done
- 🎛 **Override anything** — palette, highlights, per-variant, via `on_colors` / `on_highlights`
- 🪟 **Transparent background support** — Normal, sidebars, floats, statusline section C
- 🖥 **Neovim 0.10 / 0.11 / 0.12 compatible**
- 🎨 **Lualine theme** ships at standard `lua/lualine/themes/` path for auto-discovery

---

<details>
<summary><b>📸 Gallery — dark, light, transparent (click to expand)</b></summary>
<br>

| Variant | Preview |
|---------|---------|
| **Dark** — the canonical sunset | <img src="https://placehold.co/600x340/262335/ffffff?text=Dark+Mode&font=source-sans-pro" width="100%" alt="dark"> |
| **Light** — the violet hour | <img src="https://placehold.co/600x340/f5f0ff/1a1a2e?text=Light+Mode&font=source-sans-pro" width="100%" alt="light"> |
| **Transparent** — float on your wallpaper | <img src="https://placehold.co/600x340/111111/ffffff?text=Transparent+Mode&font=source-sans-pro" width="100%" alt="transparent"> |

</details>

---

## 📦 Installation

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

<details>
<summary><b>Other plugin managers</b></summary>

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
</details>

---

## 🚀 Usage

```lua
require("synthwave3000").setup({
  style = "auto",     -- "dark" | "light" | "auto" (follows vim.o.background)
  transparent = false, -- transparent backgrounds for Normal, sidebars, floats
})
vim.cmd.colorscheme("synthwave3000")
```

### Lualine

The theme ships a lualine theme file at `lua/lualine/themes/synthwave3000.lua`. Lualine auto-discovers it:

```lua
require("lualine").setup({
  options = { theme = "synthwave3000" },
})
```

The lualine theme respects `transparent` and `background` from your colorscheme config.

---

## ⚙️ Configuration

You don't need to call `setup()` unless you want to change something. The defaults are:

```lua
require("synthwave3000").setup({
  -- Mode ----------------------------------------------------------
  style = "auto",         -- "dark" | "light" | "auto" (follows vim.o.background)
  transparent = false,     -- transparent bg for Normal, sidebars, floats, lualine section C
  background = nil,        -- override the Normal background (nil = palette default)
  terminal_colors = true,  -- set terminal ANSI color palette

  -- Styles --------------------------------------------------------
  styles = {
    comments  = { italic = true },
    keywords  = { bold = true },
    functions = { bold = true },
    variables = {},
    strings   = {},
    types     = { bold = true },
    operators = {},
  },

  -- Plugin toggles (all enabled by default) -----------------------
  -- These exist for opt-out, not opt-in. synthwave3000 already looks
  -- Disable a toggle only if you want to override with your own setup.
  plugins = {
    telescope        = true,   nvim_tree        = true,
    neo_tree         = true,   bufferline       = true,
    gitsigns         = true,   diffview         = true,
    cmp              = true,   blink_cmp        = true,
    mini             = true,   indent_blankline = true,
    which_key        = true,   noice            = true,
    notify           = true,   trouble          = true,
    flash            = true,   snacks           = true,
    dashboard        = true,   aerial           = true,
    dap              = true,   neogit           = true,
    render_markdown  = true,
  },

  -- Customization -------------------------------------------------
  on_colors = nil,         -- function(palette) — mutate palette before highlight gen
  on_highlights = nil,     -- function(groups, palette) — override highlight groups
})
```

### Customization examples

```lua
on_colors = function(c)
  c.pink = "#ff69b4"
end

on_highlights = function(hl, c)
  hl.Comment = { fg = c.comment, italic = false }
end
```

---

## 🔌 Compatible Plugins

These plugins have been visually verified.

| Plugin | Highlights |
|--------|-----------|
| telescope.nvim | 40+ groups — picker borders, results, prompt |
| nvim-tree.lua | 40+ groups — file tree, git icons |
| neo-tree.nvim | Float border, normal, indent markers |
| bufferline.nvim | 40+ groups — tabs, separators, diagnostics, modified |
| gitsigns.nvim | Sign column, diff hunks |
| diffview.nvim | Diff panel backgrounds |
| nvim-cmp | Completion menu, documentation |
| blink.cmp | 40+ groups — menu, docs, signature help |
| mini.nvim | 80+ groups — pickers, statusline, files, diff, starter |
| indent-blankline.nvim | Indent guides, scope |
| which-key.nvim | Popup, groups, descriptions |
| noice.nvim | Cmdline popup, confirm, lsp progress |
| nvim-notify | Notification borders (severity-colored) |
| trouble.nvim | Diagnostic list backgrounds |
| flash.nvim | Uses theme defaults (hub groups) |
| snacks.nvim | 100+ groups — picker, dashboard, indent, notifier |
| dashboard-nvim | Dashboard text, keys, footer |
| aerial.nvim | Symbol outline, float border |
| nvim-dap / nvim-dap-ui | Debugger UI float border |
| neogit | Git status buffer |
| render-markdown.nvim | Headings, code blocks, links, checkboxes |

---

## 🎨 Palette

### Dark mode

| Key | Swatch | Hex | Description |
|-----|--------|-----|-------------|
| `bg` | ![#262335](https://placehold.co/15x15/262335/262335.png) | `#262335` | Main background |
| `bg_dark` | ![#0D0221](https://placehold.co/15x15/0D0221/0D0221.png) | `#0D0221` | Sidebar / float / statusline |
| `bg_darker` | ![#171520](https://placehold.co/15x15/171520/171520.png) | `#171520` | Statusline inactive / tabline fill |
| `bg_panel` | ![#2a2139](https://placehold.co/15x15/2a2139/2a2139.png) | `#2a2139` | Popup menu background |
| `fg` | ![#ffffff](https://placehold.co/15x15/ffffff/ffffff.png) | `#ffffff` | Primary foreground |
| `fg_dim` | ![#b6b1b1](https://placehold.co/15x15/b6b1b1/b6b1b1.png) | `#b6b1b1` | Dimmed / inactive text |
| `comment` | ![#848bbd](https://placehold.co/15x15/848bbd/848bbd.png) | `#848bbd` | Comments |
| `pink` | ![#FF00FF](https://placehold.co/15x15/FF00FF/FF00FF.png) | `#FF00FF` | Accent — borders, titles, selection |
| `cyan` | ![#00FFFF](https://placehold.co/15x15/00FFFF/00FFFF.png) | `#00FFFF` | Functions, special values, links |
| `green` | ![#33FF33](https://placehold.co/15x15/33FF33/33FF33.png) | `#33FF33` | Added / success / git staged |
| `yellow` | ![#fede5d](https://placehold.co/15x15/fede5d/fede5d.png) | `#fede5d` | Warnings / changed / keywords |
| `orange` | ![#f97e72](https://placehold.co/15x15/f97e72/f97e72.png) | `#f97e72` | Unsaved changes / operators |
| `red` | ![#fe4450](https://placehold.co/15x15/fe4450/fe4450.png) | `#fe4450` | Errors / deleted / types |
| `purple` | ![#8C1EFF](https://placehold.co/15x15/8C1EFF/8C1EFF.png) | `#8C1EFF` | Special identifiers / modules |

### Light mode

| Key | Swatch | Hex | Description |
|-----|--------|-----|-------------|
| `bg` | ![#f5f0ff](https://placehold.co/15x15/f5f0ff/f5f0ff.png) | `#f5f0ff` | Main background |
| `bg_dark` | ![#e8e0f0](https://placehold.co/15x15/e8e0f0/e8e0f0.png) | `#e8e0f0` | Sidebar / float / statusline |
| `bg_darker` | ![#ddd4e8](https://placehold.co/15x15/ddd4e8/ddd4e8.png) | `#ddd4e8` | Statusline inactive / tabline fill |
| `bg_panel` | ![#f0ebf8](https://placehold.co/15x15/f0ebf8/f0ebf8.png) | `#f0ebf8` | Popup menu background |
| `fg` | ![#1a1a2e](https://placehold.co/15x15/1a1a2e/1a1a2e.png) | `#1a1a2e` | Primary foreground |
| `fg_dim` | ![#5a5a7a](https://placehold.co/15x15/5a5a7a/5a5a7a.png) | `#5a5a7a` | Dimmed / inactive text |
| `comment` | ![#7c7fa0](https://placehold.co/15x15/7c7fa0/7c7fa0.png) | `#7c7fa0` | Comments |
| `pink` | ![#c445a3](https://placehold.co/15x15/c445a3/c445a3.png) | `#c445a3` | Accent — borders, titles, selection |
| `cyan` | ![#007777](https://placehold.co/15x15/007777/007777.png) | `#007777` | Functions, special values, links |
| `green` | ![#2d8f5e](https://placehold.co/15x15/2d8f5e/2d8f5e.png) | `#2d8f5e` | Added / success / git staged |
| `yellow` | ![#b0901f](https://placehold.co/15x15/b0901f/b0901f.png) | `#b0901f` | Warnings / changed / keywords |
| `orange` | ![#c0552a](https://placehold.co/15x15/c0552a/c0552a.png) | `#c0552a` | Unsaved changes / operators |
| `red` | ![#c62828](https://placehold.co/15x15/c62828/c62828.png) | `#c62828` | Errors / deleted / types |
| `purple` | ![#7c5295](https://placehold.co/15x15/7c5295/7c5295.png) | `#7c5295` | Special identifiers / modules |

---

## ♿ Accessibility

synthwave3000 takes accessibility seriously — uncommon for neon themes.

- **Dark mode**: all accents ≥ 7:1 against backgrounds (WCAG AAA)
- **Light mode**: all accents ≥ 4.5:1 against backgrounds (WCAG AA)
- Border colors and UI chrome pass WCAG 2.1 SC 1.4.11 (3:1 non-text contrast)
- No information is conveyed by color alone — error highlights pair with icons/signs

---

## 🪟 Transparency

When `transparent = true`:

| Element | Behavior |
|---------|----------|
| `Normal`, `NormalNC` | `bg = "NONE"` |
| `NormalFloat`, sidebars (`SignColumn`, `FoldColumn`) | `bg = "NONE"` |
| `StatusLine`, `WinBar`, `TabLine` section C | `bg = "NONE"` |
| Lualine section C | `bg = "NONE"` |
| `Pmenu`, floating windows | Use palette `bg_panel` (keeps readability) |
| Bufferline section A, B | Keep colored backgrounds |
| Statusline section A (mode indicator) | Keep colored background |
| Lualine sections A, B | Keep colored backgrounds |

Border colors are not affected by transparency — they remain `pink` regardless.

---

## 🧪 Testing

```bash
nvim --headless -u tests/minimal_init.lua -c "PlenaryBustedFile tests/synthwave3000_spec.lua"
```

---

## 📄 License

MIT

---

<p align="center">
  <sub>Made with neon and Lua. If it made your editor a little more electric, <a href="https://github.com/Web-Dev-Codi/synthwave3000.nvim">⭐</a>.</sub>
  <br>
  <sub>If a plugin still looks off, that's a bug we want to know about — <a href="https://github.com/Web-Dev-Codi/synthwave3000.nvim/issues">open an issue</a>.</sub>
</p>

---

<p align="center">
  <img src="https://placehold.co/800x4/ff00ff/ff00ff.png" width="800" height="4" alt="footer gradient">
</p>
