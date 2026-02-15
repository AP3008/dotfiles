return {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Minimal header (clean + matches rose-pine vibe)
dashboard.section.header.val = {
  " ",
  "░█████╗░██████╗░░█████╗░███╗░░░███╗██╗",
  "██╔══██╗██╔══██╗██╔══██╗████╗░████║██║",
  "███████║██║░░██║███████║██╔████╔██║██║",
  "██╔══██║██║░░██║██╔══██║██║╚██╔╝██║╚═╝",
  "██║░░██║██████╔╝██║░░██║██║░╚═╝░██║██╗",
  "╚═╝░░╚═╝╚═════╝░╚═╝░░╚═╝╚═╝░░░░░╚═╝╚═╝",
  " ",
}
		-- Buttons (requires Telescope for f/g/r)
		dashboard.section.buttons.val = {
			dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
			dashboard.button("g", "󰱼  Live grep", ":Telescope live_grep<CR>"),
			dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
			dashboard.button("c", "  Config", ":e $MYVIMRC<CR>"),
			dashboard.button("q", "  Quit", ":qa<CR>"),
		}

		-- Subtle footer
		dashboard.section.footer.val = {
			" ",
			"      main · moon · dawn",
		}

		-- Layout spacing (adjust padding if you want it higher/lower)
		dashboard.config.layout = {
			{ type = "padding", val = 6 },
			dashboard.section.header,
			{ type = "padding", val = 2 },
			dashboard.section.buttons,
			{ type = "padding", val = 2 },
			dashboard.section.footer,
		}

		-- Setup Alpha
		alpha.setup(dashboard.config)

		-- Transparency (so Ghostty opacity shows through)
		-- These highlights are safe even if you later change themes.
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
		vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
		vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
		vim.api.nvim_set_hl(0, "AlphaNormal", { bg = "none" })
	end,
}
