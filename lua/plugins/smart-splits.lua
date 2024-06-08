return {
  {
    'mrjones2014/smart-splits.nvim',
    -- turn off lazy loading to work with wezterm integration.  We want plugin to set user var
    -- indicating vim is running on vim startup
    lazy = false,
  },
  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          -- Reset keys for resizing split windows.   Defaults were using Ctrl-Arrow which conflicts with macOS
          ["<M-Up>"] = {
            function() require("smart-splits").resize_up() end,
            desc = "Resize split up"
          },
          ["<M-Down>"] = {
            function() require("smart-splits").resize_down() end,
            desc = "Resize split down"
          },
          ["<M-Left>"] = {
            function() require("smart-splits").resize_left() end,
            desc = "Resize split left"
          },
          ["<M-Right>"] = {
            function() require("smart-splits").resize_right() end,
            desc = "Resize split right"
          },
          ["<C-S-Left>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" },
          ["<C-S-Down>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" },
          ["<C-S-Up>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" },
          ["<C-S-Right>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" },
        },
      },
    }
  }
}
