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
