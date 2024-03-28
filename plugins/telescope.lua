return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-telescope/telescope-live-grep-args.nvim" },
    config = function()
      -- Allows passing arbitrary args to ripgrep in the find words search box.  See
      -- https://github.com/nvim-telescope/telescope-live-grep-args.nvim
      require("telescope").load_extension("live_grep_args")
    end,
    keys = {
      {
        "<leader>fw",
        function() require("telescope").extensions.live_grep_args.live_grep_args() end,
        desc = "Find words (with args)"
      },
      {
        "<leader>fc",
        function() require("telescope-live-grep-args.shortcuts").grep_word_under_cursor() end,
        desc = "Find for word under cursor"
      },
      {
        "<leader>fv",
        function() require("telescope-live-grep-args.shortcuts").grep_visual_selection() end,
        mode = "v",
        desc = "Find visual selection"
      },
    },
  },
}
