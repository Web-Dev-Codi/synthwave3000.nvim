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
