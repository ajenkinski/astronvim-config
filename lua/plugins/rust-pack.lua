-- Customize astrocommunity rust pack
return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      handlers = {
        codelldb = function(config)
          -- Work around macOS problem with codelldb.  For some reason, any attempt to debug was erroring out with a
          -- "Process exited with code -1" error. After googling I found that the problem can be resolved by deleting
          -- the debugserver command that comes with codelldb. I just rename it instead so it can be undone, by adding a
          -- "_" to the end.
          -- See here for discussion: https://github.com/vadimcn/codelldb/issues/999
          -- I gather that the debugserver that's included with codelldb is copied from an older version of Xcode.  The
          -- motivation for including it with codelldb is so users won't need Xcode installed.  It's unnecessary if you
          -- do have Xcode. Deleting this version makes codelldb fall back on using the version that comes with Xcode.

          if vim.uv.os_uname().sysname == "Darwin" then
            -- use realpath in case command is a symlink
            local cmd = vim.uv.fs_realpath(config.adapters.executable.command)
            local codelldb_dir = vim.fs.dirname(cmd)
            local dsfile = vim.fs.joinpath(codelldb_dir, "extension/lldb/bin/debugserver")
            if vim.uv.fs_stat(dsfile) then
              vim.uv.fs_rename(dsfile, dsfile .. "_")
            end
          end

          require('mason-nvim-dap').default_setup(config)
        end,
      },
    },
  },
}

