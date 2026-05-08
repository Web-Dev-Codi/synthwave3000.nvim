describe("synthwave3000", function()
  it("sets vim.g.colors_name", function()
    assert.equals("synthwave3000", vim.g.colors_name)
  end)

  it("defines Normal with fg and bg", function()
    local hl = vim.api.nvim_get_hl(0, { name = "Normal" })
    assert.is_not_nil(hl.fg)
    assert.is_not_nil(hl.bg)
  end)

  it("defines all required Tree-sitter groups", function()
    local groups = {
      "@variable", "@function", "@keyword", "@type",
      "@string", "@comment", "@markup.heading",
      "@markup.raw", "@markup.link.url",
    }
    for _, g in ipairs(groups) do
      local hl = vim.api.nvim_get_hl(0, { name = g })
      assert.is_true(next(hl) ~= nil, "missing group: " .. g)
    end
  end)

  it("defines Added/Changed/Removed (0.10 regression)", function()
    for _, g in ipairs({ "Added", "Changed", "Removed" }) do
      local hl = vim.api.nvim_get_hl(0, { name = g })
      assert.is_true(next(hl) ~= nil, "missing: " .. g)
    end
  end)

  it("WCAG AA on default dark bg", function()
    local C = require("synthwave3000.util").contrast
    local p = require("synthwave3000.palette").build({ style = "dark" })
    assert.is_true(C(p.pink, p.bg) >= 4.5)
    assert.is_true(C(p.cyan, p.bg) >= 4.5)
    assert.is_true(C(p.yellow, p.bg) >= 4.5)
    assert.is_true(C(p.green, p.bg) >= 4.5)
    assert.is_true(C(p.orange, p.bg) >= 4.5)
    assert.is_true(C(p.red, p.bg) >= 4.5)
    assert.is_true(C(p.comment, p.bg) >= 4.5)
  end)

  it("WCAG AA on default light bg", function()
    local C = require("synthwave3000.util").contrast
    local p = require("synthwave3000.palette").build({ style = "light" })
    assert.is_true(C(p.pink, p.bg) >= 4.5)
    assert.is_true(C(p.cyan, p.bg) >= 4.5)
    assert.is_true(C(p.yellow, p.bg) >= 4.5)
    assert.is_true(C(p.green, p.bg) >= 4.5)
    assert.is_true(C(p.orange, p.bg) >= 4.5)
    assert.is_true(C(p.red, p.bg) >= 4.5)
    assert.is_true(C(p.comment, p.bg) >= 4.5)
  end)

  it("light palette is returned when style=light", function()
    local p = require("synthwave3000.palette").build({ style = "light" })
    assert.equals("#f5f0ff", p.bg)
    assert.equals("#1a1a2e", p.fg)
  end)

  it("dark palette is returned when style=dark", function()
    local p = require("synthwave3000.palette").build({ style = "dark" })
    assert.equals("#262335", p.bg)
    assert.equals("#ffffff", p.fg)
  end)
end)
