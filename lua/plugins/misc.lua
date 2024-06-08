-- Plugins that I haven't wanted to move to their own file yet
return {
  {
    "tpope/vim-fugitive",
    -- Load the first time a git-managed file is opened.  This is to work around a conflict with gitsigns, which 
    -- is also loaded on this event. Gitsigns has its own :Gitsigns user command, which prevents this package
    -- from being autoloaded based on the command if gitsigns loads first, because then nvim treats :Git as an
    -- abbreviation of :Gitsigns instead of as a missing command.  See ":help user-cmd-ambiguous" for info on
    -- nvim's abbreviation behaviour.
    event = "User AstroGitFile",
    cmd = "Git",
  },
  -- Extension to vim-fugitive to allow opening files in github with the GBrowse command
  { "tpope/vim-rhubarb",  event = "User AstroGitFile", dependencies = { "tpope/vim-fugitive" } },

  -- https://github.com/tpope/vim-abolish
  { "tpope/vim-abolish", cmd = {"Abolish", "Subvert"} },

  -- https://github.com/simrat39/rust-tools.nvim
  -- "simrat39/rust-tools.nvim",
  {
    "windwp/nvim-autopairs",
    opts = {
      fast_wrap = {
        -- Configure the shortcut key for quickly wrapping text in delimiters such as (), {}, etc.
        -- After typing opening delimiter, hit short cut key to select where closing delimiter should go.
        -- See :help nvim-autopairs for more info
        map = "<C-e>",

        -- Make color of potentially wrapped text easier to see
        highlight_grey = "Pmenu",
      },
    }
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      dim_inactive = {
        enabled = true,
        percentage = 0.01,
      },
      color_overrides = {
        mocha = {
          -- make the border between splits easier to see
          crust = "#43465A",
        },
      },
    },
  },
  -- AstroNvim includes this, but I don't want it.  It makes typing "jk" in insert mode be treated as Esc
  {
    "max397574/better-escape.nvim",
    enabled = false,
  },
  {
    "stevearc/aerial.nvim",
    opts = {
      -- Limit the kinds of symbols shown in symbol map brought up by <leader>lS
      filter_kind = {
        "Class",
        "Constructor",
        "Function",
        "Method",
      },
    }
  },
}
