return {
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    opts = {
      colors = {
        dark = {
          bg = "#1e1f22",
          bg_statusline = "#2b2d30",
          comment = "#7a7e85",
        },
      },
      highlights = {
        ["@keyword"] = { italic = true },
        ["@keyword.function"] = { italic = true },
        ["@comment"] = { italic = true },
        ["@type"] = { bold = true },
        ["@function"] = { bold = true },
        ["@constructor"] = { bold = true },
        CursorLine = { bg = "#2b2d30" },
        LineNr = { fg = "#4e5157" },
        CursorLineNr = { fg = "#9da5b4", bold = true },
        WinSeparator = { fg = "#3d4043" },
      },
      styles = {
        types = "bold",
        methods = "bold",
        numbers = "NONE",
        strings = "NONE",
        comments = "italic",
        keywords = "italic",
        constants = "NONE",
        functions = "bold",
        operators = "NONE",
        variables = "NONE",
        parameters = "NONE",
        conditionals = "italic",
        virtual_text = "italic",
      },
      options = {
        bold = true,
        italic = true,
        underline = true,
        undercurl = true,
        cursorline = true,
        transparency = false,
        terminal_colors = true,
        lualine_transparency = false,
        highlight_inactive_windows = true,
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark_vivid",
    },
  },
}
