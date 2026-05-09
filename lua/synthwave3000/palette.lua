local M = {}

local dark = {
	bg = "#262335",
	bg_dark = "#0D0221",
	bg_darker = "#171520",
	bg_panel = "#2a2139",
	bg_highlight = "#34294f",
	bg_visual = "#413f4e",
	fg = "#ffffff",
	fg_dim = "#b6b1b1",
	comment = "#848bbd",
	pink = "#FF00FF",
	cyan = "#00FFFF",
	green = "#33FF33",
	yellow = "#fede5d",
	orange = "#f97e72",
	orange_bright = "#ff8b39",
	red = "#fe4450",
	purple = "#8C1EFF",
	blue = "#03edf9",
	selection = "#463465",
	none = "NONE",
}

local light = {
	bg = "#f5f0ff",
	bg_dark = "#e8e0f0",
	bg_darker = "#ddd4e8",
	bg_panel = "#f0ebf8",
	bg_highlight = "#ddd4e8",
	bg_visual = "#dad5e5",
	fg = "#1a1a2e",
	fg_dim = "#5a5a7a",
	comment = "#7c7fa0",
	pink = "#c445a3",
	cyan = "#007777",
	green = "#2d8f5e",
	yellow = "#b0901f",
	orange = "#c0552a",
	orange_bright = "#d4652a",
	red = "#c62828",
	purple = "#7c5295",
	blue = "#0288d1",
	selection = "#d0c0e8",
	none = "NONE",
}

function M.build(opts)
	opts = opts or {}
	if opts.style == "light" then
		return vim.deepcopy(light)
	end
	return vim.deepcopy(dark)
end

return M
