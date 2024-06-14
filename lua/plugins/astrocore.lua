-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = {
        expandtab = true,

        -- Set window/tab title to the filename.  See ":help title" for more info
        title = true,
        -- Set window/tab title to this when nvim exits, to undo the title change due to above
        titleold = "bash",
      },
      g = {
        neovide_cursor_animation_length = 0.01,
        neovide_scroll_animation_length = 0.1,

        -- Explicitly specify python to use for neovim's python3 provider.  Without this, startup time is slow
        -- because it searches for a suitable installation.  If this virtualenv goes away, it could also cause
        -- slowdown, because then nvim might go back to search for a valid installation.  Can also entirely disable
        -- python3 provider with:
        -- loaded_python3_provider = 0,
        -- See ":help provider-python" for more info
        python3_host_prog = "/Users/ajenkins/Envs/nvim-plugins/bin/python",
      }
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      n = {
        ["<Leader>fb"] = {
          function() require("telescope.builtin").buffers({ sort_mru = true }) end,
          desc = "Find buffers"
        },
      },
      v = {
        ["<M-c>"] = {
          "\"*y",
          desc = "Copy selection to clipboard"
        },
      },
    },
    -- Define global user commands here
    commands = {
      -- Open a project in a new vim tab.  For now this just means setting the tab's cwd to the specified
      -- directory, but I could expand it to do more.
      ProjectOpen = {
        "tabnew +tcd\\ <args>",
        nargs = 1,
        complete = "dir",
        desc = "Open a project in a new vim tab",
      },
    }
  },
}
