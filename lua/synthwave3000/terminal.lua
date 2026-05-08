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
