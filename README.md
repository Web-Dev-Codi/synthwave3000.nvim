# synthwave3000.nvim

A Neovim colorscheme inspired by Robb Owen's [Synthwave '84](https://github.com/robb0wen/synthwave-vscode) VS Code theme.

Dark mode with the canonical Synthwave '84 palette + light mode with an inverted variant. WCAG AA compliant. 17+ plugin integrations.

## Features

- Dark + Light mode with `style = "auto" | "dark" | "light"`
- Synthwave "glow" effect approximation (bold + brightened fg)
- WCAG AA contrast (>=4.5:1) on all backgrounds
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
Plug 'Web-Dev-Codi/synthwave3000.nvim"
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

| Option | Default | Description |
|--------|---------|-------------|
| `style` | `"auto"` | `"dark"`, `"light"`, or `"auto"` (follows vim.o.background) |
| `transparent` | `false` | Transparent backgrounds for Normal, sidebar, etc. |
| `terminal_colors` | `true` | Set terminal ANSI colors |
| `glow.enabled` | `true` | Synthwave glow (auto-disables in light mode) |
| `glow.brighten` | `0.10` | HSL lightness boost for glow groups |
| `glow.background` | `false` | Faint background halo for glow groups |

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

### Plugin Toggle

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

```lua
on_colors = function(c)
  c.pink = "#ff69b4"
end

on_highlights = function(hl, c)
  hl.Comment = { fg = c.comment, italic = false }
end
```

## Supported Plugins

telescope.nvim, nvim-tree.lua, neo-tree.nvim, bufferline.nvim, lualine.nvim, gitsigns.nvim, diffview.nvim, nvim-cmp, blink.cmp, mini.nvim, indent-blankline.nvim, which-key.nvim, noice.nvim, nvim-notify, trouble.nvim, flash.nvim, snacks.nvim

## Testing

```bash
nvim --headless -u tests/minimal_init.lua -c "PlenaryBustedFile tests/synthwave3000_spec.lua"
```

## License

MIT
