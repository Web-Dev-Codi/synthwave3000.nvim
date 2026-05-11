# cybersynth.nvim — README Checklist

## 🦸 Hero Block
- [ ] Centered logo image (`<div align="center">`)
- [ ] Theme name as `<h1>` inside the div
- [ ] One-line emotional tagline (e.g. *"The synthwave colorscheme that styles plugins it's never met."*)
- [ ] Shields.io badge row — stars, issues, license, Neovim version, Lua, WCAG — all styled with synthwave hex (`labelColor=241b2f`)
- [ ] ONE killer screenshot or GIF above the fold

---

## ✍️ Why cybersynth? (Manifesto)
- [ ] Names the pain point (themes with 80 integrations, neon themes that fail contrast)
- [ ] States the USP in ≤3 sentences (plugin-agnostic, WCAG AAA dark / AA light, light mode with same hue families)
- [ ] Ends with a cultural hook referencing the synthwave genre

---

## ✨ Features List
- [ ] 🔌 Plugin-agnostic by design — hub-group inheritance, no config needed
- [ ] ♿ WCAG AAA on dark, AA on light — every accent verified
- [ ] 🌗 First-class light mode — same hue families, recalibrated lightness
- [ ] ⚡ Zero required config — `colorscheme cybersynth` and done
- [ ] 🎛 Override anything — `on_colors` / `on_highlights` callbacks
- [ ] 🖥 Extras for Kitty, WezTerm, Alacritty, Ghostty, tmux, Fish, bat, delta

---

## 🖼 Showcase Gallery
- [ ] Screenshot per variant: dark, noir, dawn (light), vapor (or equivalent)
- [ ] Each captioned with a one-liner genre reference
- [ ] Images linked to full-res versions

---

## 📦 Installation
- [ ] lazy.nvim snippet (primary — most users)
- [ ] packer.nvim, vim-plug, rocks.nvim in a `<details>` accordion
- [ ] Both Lua and Vimscript usage one-liners

---

## ⚙️ Configuration
- [ ] Full default opts block in one code fence
- [ ] Inline `--` comments as docs (no separate prose needed)
- [ ] Note: "no need to call `setup()` unless you want to change something"

---

## 🔌 Plugin Support Section
- [ ] Explain *why* there's nothing to enable (the `default = true` / hub-group mechanism, 1 paragraph)
- [ ] `<details>` list of visually verified plugins (not a config table — just a visual showcase)
- [ ] Frame any explicitly-tuned plugin as "extra polish," not a required integration

---

## 🪓 Overrides & Recipes
- [ ] Palette getter example (`require('cybersynth').get_colors()`)
- [ ] Single highlight override snippet
- [ ] Transparent background recipe
- [ ] Lualine / statusline attach example

---

## 🎨 Palette Tables
- [ ] HTML swatch table using `placehold.co` color chips
- [ ] Dark hex + light hex + role, side by side per color
- [ ] Cover: magenta, cyan, mint, yellow, coral, red, violet, lavender, all bg/fg tones

---

## ⚔️ Comparison Table
- [ ] cybersynth vs. "theme with 80 integrations" (don't name specific themes)
- [ ] Rows: works on unseen plugins / new-plugin PRs needed / config size / user override always wins / light mode parity

---

## 🍭 Extras
- [ ] Terminal configs listed (Kitty, WezTerm, Alacritty, Ghostty, tmux, Fish, bat, delta, Helix)
- [ ] Each in its own `<details>` with install snippet

---

## 🙋 FAQ / Compatibility
- [ ] Neovim ≥ 0.10 requirement stated
- [ ] Truecolor terminal note
- [ ] tmux italics/undercurls fix
- [ ] "Plugin still looks wrong" → explain it's an upstream issue + how to file it

---

## 📈 Social Proof
- [ ] Star history graph (star-history.com embed)
- [ ] Last-commit badge + latest-release badge
- [ ] Contributors avatar grid (use `contrib.rocks` or GitHub's contributor image)

---

## 🔥 Closing CTA
- [ ] Explicit star invitation ("If it made your editor more electric, drop a ⭐")
- [ ] Bug report invitation ("If a plugin looks off, that's a bug — open an issue")
- [ ] License badge + "MIT" stated plainly

---

## 🎨 Visual Polish
- [ ] `<div align="center">` wrapping hero, gallery, and footer
- [ ] All badges use `style=for-the-badge` with synthwave `labelColor`
- [ ] Emoji used as section-header punctuation throughout
- [ ] Thin gradient SVG banner (magenta→cyan) as footer separator (`assets/footer.svg`)
- [ ] Color swatch chips in palette table via `placehold.co/15x15/<hex>/<hex>.png`
- [ ] Long config/integration sections behind `<details><summary>` accordions
- [ ] No wall-of-text paragraphs — bullets and short prose only

---

## ✅ Final Checks
- [ ] Screenshot/GIF visible within first screen-height (no scrolling required to see the theme)
- [ ] Copy-paste install works cold (tested in a clean `nvim --clean`)
- [ ] All badge URLs point to correct repo paths
- [ ] Light mode screenshot actually looks good, not washed out
- [ ] WCAG contrast ratios re-verified at webaim.org/resources/contrastchecker before publishing
