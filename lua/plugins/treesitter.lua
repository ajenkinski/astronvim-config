-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      "lua",
      "vim",
      -- add more arguments for adding more treesitter parsers
    })

    -- Automatically install available tree-sitter parsers when first entering a buffer a new file type.
    opts.auto_install = true
    -- sync_install=false was causing errors.  When it's false, it allows mutliple installs to happen at the same time. 
    -- It seems sometimes it was trying to install the same parser twice at the same time, causing an error.
    opts.sync_install = true
  end,
  config = function(_, opts)
      -- what astronvim parent config would have done
      require("nvim-treesitter.configs").setup(opts)

      -- Use my local modded lalrpop treesitter
      local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
      -- parser_config.lalrpop = {
      --   install_info = {
      --     url = "~/dev/tree-sitter-lalrpop",           -- local path or git repo
      --     files = { "src/parser.c", "src/scanner.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
      --     -- optional entries:
      --     branch = "support-comments",                 -- default branch in case of git repo if different from master
      --   },
      -- }

      -- Use my local modded starlark treesitter, which has a fix for f-strings
      parser_config.starlark = {
        install_info = {
          url = "~/dev/tree-sitter-starlark",
          files = { "src/parser.c", "src/scanner.c" },
          branch = "f-string-fixes",
          filetype = "bzl",
        },
      }
    end,
}
