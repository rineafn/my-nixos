return {
  {
    "vyfor/cord.nvim",
    build = "./build",
    event = "VeryLazy",
    opts = {
      editor = {
        client = "neovim",
        tooltip = "The One True Editor",
      },
      display = {
        theme = "onedark",
        flavor = "dark",
      },
      timestamp = {
        enabled = true,
        reset_on_idle = false,
        reset_on_change = false,
      },
      idle = {
        enabled = true,
        timeout = 300000,
        show_status = true,
        details = "Idling",
      },
      text = {
        viewing = "Viewing {}",
        editing = "Editing {}",
        file_browser = "Browsing files in {}",
        plugin_manager = "Managing plugins in {}",
        workspace = "In {}",
      },
    },
  },
}
