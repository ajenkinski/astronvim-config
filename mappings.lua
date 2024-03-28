-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
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

    ["<leader>fb"] = {
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
}
