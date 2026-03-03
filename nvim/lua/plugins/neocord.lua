return {
  "vyfor/cord.nvim",
  build = "./build",
  event = "VeryLazy",
  opts = {
    editor = {
      tooltip = "The One True Text Editor",
    },
    text = {
      editing   = function(opts) return "Editing " .. opts.filename end,
      viewing   = function(opts) return "Viewing " .. opts.filename end,
      workspace = function(opts) return "Working on " .. opts.workspace end,
    },
    advanced = {
      plugin = {
        pipe = "/var/folders/xb/7mdb1xrj4gl8p0qp_p155kmr0000gn/T/discord-ipc-0",
      }
    }
  },
}
