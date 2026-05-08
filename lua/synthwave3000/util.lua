local M = {}

function M.hex_to_rgb(hex)
  hex = hex:gsub("#", "")
  return tonumber(hex:sub(1, 2), 16),
    tonumber(hex:sub(3, 4), 16),
    tonumber(hex:sub(5, 6), 16)
end

function M.rgb_to_hex(r, g, b)
  return string.format("#%02x%02x%02x", r, g, b)
end

function M.rgb_to_hsluv(r, g, b)
  r, g, b = r / 255, g / 255, b / 255
  local max, min = math.max(r, g, b), math.min(r, g, b)
  local l = (max + min) / 2
  if max == min then
    return 0, 0, l * 100
  end
  local d = max - min
  local s = l > 0.5 and d / (2 - max - min) or d / (max + min)
  local h = 0
  if max == r then
    h = (g - b) / d + (g < b and 6 or 0)
  elseif max == g then
    h = (b - r) / d + 2
  else
    h = (r - g) / d + 4
  end
  h = h / 6
  return h * 360, s * 100, l * 100
end

function M.hsluv_to_rgb(h, s, l)
  h, s, l = h / 360, s / 100, l / 100
  if s == 0 then
    l = l * 255
    return l, l, l
  end
  local function hue2rgb(p, q, t)
    if t < 0 then t = t + 1 end
    if t > 1 then t = t - 1 end
    if t < 1 / 6 then return p + (q - p) * 6 * t end
    if t < 1 / 2 then return q end
    if t < 2 / 3 then return p + (q - p) * (2 / 3 - t) * 6 end
    return p
  end
  local q = l < 0.5 and l * (1 + s) or l + s - l * s
  local p = 2 * l - q
  return hue2rgb(p, q, h + 1 / 3) * 255,
    hue2rgb(p, q, h) * 255,
    hue2rgb(p, q, h - 1 / 3) * 255
end

function M.brighten(hex, amount)
  local r, g, b = M.hex_to_rgb(hex)
  local h, s, l = M.rgb_to_hsluv(r, g, b)
  l = math.min(100, l + amount * 100)
  r, g, b = M.hsluv_to_rgb(h, s, l)
  return M.rgb_to_hex(math.floor(r + 0.5), math.floor(g + 0.5), math.floor(b + 0.5))
end

function M.darken(hex, amount)
  local r, g, b = M.hex_to_rgb(hex)
  local h, s, l = M.rgb_to_hsluv(r, g, b)
  l = math.max(0, l - amount * 100)
  r, g, b = M.hsluv_to_rgb(h, s, l)
  return M.rgb_to_hex(math.floor(r + 0.5), math.floor(g + 0.5), math.floor(b + 0.5))
end

function M.blend(fg, bg, alpha)
  local fr, fg_b, fb = M.hex_to_rgb(fg)
  local br, bg_b, bb = M.hex_to_rgb(bg)
  local function blend_channel(f, b)
    return math.floor(f * alpha + b * (1 - alpha) + 0.5)
  end
  return M.rgb_to_hex(
    blend_channel(fr, br),
    blend_channel(fg_b, bg_b),
    blend_channel(fb, bb)
  )
end

function M.contrast(fg, bg)
  local function lum(hex)
    local r, g, b = M.hex_to_rgb(hex)
    local function chan(c)
      c = c / 255
      return c <= 0.03928 and c / 12.92 or ((c + 0.055) / 1.055) ^ 2.4
    end
    return 0.2126 * chan(r) + 0.7152 * chan(g) + 0.0722 * chan(b)
  end
  local l1, l2 = lum(fg), lum(bg)
  if l1 < l2 then
    l1, l2 = l2, l1
  end
  return (l1 + 0.05) / (l2 + 0.05)
end

return M
