local M = {}

function M.build(p, o)
  local function mode(fg, bg)
    return {
      a = { fg = fg, bg = bg, gui = "bold" },
      b = { fg = p.fg, bg = p.bg_highlight },
      c = { fg = p.fg, bg = p.bg_dark },
    }
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
