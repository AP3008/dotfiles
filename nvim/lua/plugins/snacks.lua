return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		local Snacks = require("snacks")

		Snacks.setup({
			bigfile = { enabled = false },
			explorer = { enabled = false },
			indent = { enabled = true },
			input = { enabled = false },
			picker = { enabled = false },
			quickfile = { enabled = false },
			scope = { enabled = false },
			scroll = { enabled = false },
			statuscolumn = { enabled = false },
			words = { enabled = false },

			notifier = {
				enabled = true,
				timeout = 3000,
			},

			dashboard = {
				enabled = true,
				preset = {
					header = "",
				},
				sections = {
					-- ── Left pane ──
					{
						pane = 1,
						section = "terminal",
						cmd = [[printf '\033[38;5;176m░█████╗░██████╗░░█████╗░███╗░░░███╗██╗\033[0m\n\033[38;5;175m██╔══██╗██╔══██╗██╔══██╗████╗░████║██║\033[0m\n\033[38;5;139m███████║██║░░██║███████║██╔████╔██║██║\033[0m\n\033[38;5;103m██╔══██║██║░░██║██╔══██║██║╚██╔╝██║╚═╝\033[0m\n\033[38;5;110m██║░░██║██████╔╝██║░░██║██║░╚═╝░██║██╗\033[0m\n\033[38;5;116m╚═╝░░╚═╝╚═════╝░╚═╝░░╚═╝╚═╝░░░░░╚═╝╚═╝\033[0m']],
						height = 6,
						padding = 1,
					},
					{
						pane = 1,
						icon = " ",
						title = "Keymaps",
						section = "keys",
						indent = 2,
						padding = 1,
					},
					{
						pane = 1,
						icon = " ",
						title = "Recent Files",
						section = "recent_files",
						indent = 2,
						padding = 1,
					},
					{
						pane = 1,
						icon = " ",
						title = "Projects",
						section = "projects",
						indent = 2,
						padding = 1,
					},
					{
						pane = 1,
						icon = "󰄬 ",
						title = "Project TODOs",
						section = "terminal",
						cmd = [[result=$(rg -n --no-heading -g '!node_modules' -g '!*.min.*' -g '!*.lock' -g '!.git' -g '!snacks.lua' -g '!*.json' "// (TODO|FIXME|HACK):|# (TODO|FIXME|HACK):|-- (TODO|FIXME|HACK):" 2>/dev/null | head -n 8 | while IFS= read -r line; do file="${line%%:*}"; rest="${line#*:}"; rest="${rest#*:}"; path=$(basename "$file"); printf "  \033[36m%s\033[0m \033[35m→\033[0m %s\n" "$path" "$rest"; done | cut -c 1-70); if [ -n "$result" ]; then echo "$result"; else echo "  \033[35mNo TODOs found\033[0m"; fi]],
						height = 8,
						padding = 1,
						ttl = 0,
						cache = false,
						indent = 2,
					},
					-- ── Right pane ──
					{
						pane = 2,
						section = "terminal",
						cmd = "colorscript -e square",
						height = 4,
						padding = 1,
					},
					{
						pane = 2,
						section = "terminal",
						cmd = [[echo -e "\u001b[35m󱉭  Current Project: \u001b[0m\u001b[1m\u001b[36m$(basename $(git rev-parse --show-toplevel 2>/dev/null || pwd))\u001b[0m"]],
						height = 1,
						padding = { 1, 0 },
						cache = false,
					},
					function()
						local in_git = Snacks.git.get_root() ~= nil
						local cmds = {
							{
								title = "Not a git repo",
								cmd = "echo '  ¯\\_(ツ)_/¯  Not a git repo'",
								icon = " ",
								height = 2,
								enabled = not in_git,
							},
							{
								icon = "󰂚 ",
								title = "Notifications",
								cmd = [[GH_FORCE_TTY=100% gh api "notifications?all=true" --jq '.[0:6] | .[] | (now - (.updated_at | fromdateiso8601)) as $d | (if $d < 3600 then "\(($d/60|floor))m" elif $d < 86400 then "\(($d/3600|floor))h" elif $d < 604800 then "\(($d/86400|floor))d" elif $d < 2592000 then "\(($d/604800|floor))w" else "\(($d/2592000|floor))mo" end) as $time | "\u001b[35m" + ($time + (" " * (4 - ($time|length)))) + "\u001b[0m \u001b[36m" + .repository.full_name + "\u001b[0m \u001b[35m→\u001b[0m " + .subject.title' 2>/dev/null | cut -c 1-80 || echo "  No notifications"]],
								height = 4,
							},
							{
								icon = " ",
								title = "Git Status",
								cmd = [[s=$(git diff --stat=50 --stat-graph-width=15 -B -M -C --color=always); if [ -z "$s" ]; then echo -e "  \u001b[32m󰄬 \u001b[0m \u001b[35mUp to date\u001b[0m"; else echo "$s"; fi]],
								height = 6,
							},
							{
								icon = "⎇ ",
								title = "Commits History",
								cmd = [[git log --graph --all --color=always -n 7 --format='%C(magenta)%h %C(cyan)%s %C(white)(%cr)' | cut -c 1-80]],
								height = 7,
							},
							{
								icon = " ",
								title = "Open Issues",
								cmd = [[GH_FORCE_TTY=100% gh issue list -L 4 --json updatedAt,number,title --template '{{range .}}{{.updatedAt}}@{{.number}}@{{.title}}{{"\n"}}{{end}}' 2>/dev/null | while IFS=@ read -r date num title; do printf "  \033[35m#%s\033[0m %s\n" "$num" "$title"; done || echo "  No issues or gh not available"]],
								height = 4,
							},
						}
						return vim.tbl_map(function(cmd)
							return vim.tbl_extend("force", {
								pane = 2,
								section = "terminal",
								enabled = in_git,
								padding = 1,
								cache = false,
								ttl = 0,
								indent = 3,
							}, cmd)
						end, cmds)
					end,
					-- ── Footer ──
					{ section = "startup" },
				},
			},

			styles = {
				notification = {},
			},
		})

		-- Transparency (so Ghostty opacity shows through)
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
		vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
		vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
		vim.api.nvim_set_hl(0, "SnacksDashboardNormal", { bg = "none" })
	end,
}
