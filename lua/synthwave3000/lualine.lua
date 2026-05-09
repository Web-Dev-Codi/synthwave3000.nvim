local M = {}

function M.get_theme()
  local config = require("synthwave3000").config
  if not config then
    config = require("synthwave3000.config").extend()
  end

  local palette = require("synthwave3000.palette").build(config)
  if config.on_colors then
    config.on_colors(palette)
  end

  local p = palette
  local o = config

  local bg = o.transparent and "NONE" or (o.background or p.bg)
  local bg_dark = o.transparent and "NONE" or p.bg_dark
  local bg_darker = o.transparent and "NONE" or p.bg_darker

  local function mode(fg, bg_color)
    return {
      a = { fg = fg, bg = bg_color, gui = "bold" },
      b = { fg = p.fg, bg = p.bg_highlight },
      c = { fg = p.fg, bg = bg_dark },
    }
  end

  return {
    normal = mode(bg, p.pink),
    insert = mode(bg, p.cyan),
    visual = mode(bg, p.purple),
    replace = mode(bg, p.orange),
    command = mode(bg, p.yellow),
    terminal = mode(bg, p.green),
    inactive = {
      a = { fg = p.fg_dim, bg = bg_darker, gui = "bold" },
      b = { fg = p.fg_dim, bg = bg_darker },
      c = { fg = p.fg_dim, bg = bg_darker },
    },
  }
end

return M
