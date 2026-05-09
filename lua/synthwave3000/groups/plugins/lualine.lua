local M = {}

function M.build(p, o)
  local bg = o.transparent and "NONE" or (o.background or p.bg)
  local bg_dark = o.transparent and "NONE" or p.bg_dark
  local bg_darker = o.transparent and "NONE" or p.bg_darker
  local function mode(fg, bg)
    return {
      a = { fg = fg, bg = bg, gui = "bold" },
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
