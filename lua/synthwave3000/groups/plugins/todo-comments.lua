local function build(p, o)
  return {
    TodoFgFIX = { fg = p.red },
    TodoBgFIX = { bg = p.bg_highlight },
    TodoSignFIX = { fg = p.red },
    TodoFgTODO = { fg = p.yellow },
    TodoBgTODO = { bg = p.bg_highlight },
    TodoSignTODO = { fg = p.yellow },
    TodoFgHACK = { fg = p.purple },
    TodoBgHACK = { bg = p.bg_highlight },
    TodoSignHACK = { fg = p.purple },
    TodoFgWARN = { fg = p.orange },
    TodoBgWARN = { bg = p.bg_highlight },
    TodoSignWARN = { fg = p.orange },
    TodoFgPERF = { fg = p.cyan },
    TodoBgPERF = { bg = p.bg_highlight },
    TodoSignPERF = { fg = p.cyan },
    TodoFgNOTE = { fg = p.blue },
    TodoBgNOTE = { bg = p.bg_highlight },
    TodoSignNOTE = { fg = p.blue },
    TodoFgTEST = { fg = p.green },
    TodoBgTEST = { bg = p.bg_highlight },
    TodoSignTEST = { fg = p.green },
  }
end

return { build = build }
