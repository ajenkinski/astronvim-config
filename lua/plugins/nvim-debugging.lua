-- Support for interactively debugging nvim lua code
-- See ":help osv"
-- or
-- See https://github.com/jbyuki/one-small-step-for-vimkind
--
-- I've set it so that where in the instructions above it says to use <F5> to start the debug server
-- instead you'd use the :OsvLaunch command. 

local nlua_port = 8086

return {
  {
    "jbyuki/one-small-step-for-vimkind",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
  {
    "mfussenegger/nvim-dap",
    config = function ()
      local dap = require("dap")
      dap.configurations.lua = {
        {
          type = 'nlua',
          request = 'attach',
          name = "Attach to running Neovim instance",
        }
      }

      dap.adapters.nlua = function(callback, config)
        callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or nlua_port })
      end
    end,
  },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      commands = {
      -- Use this instead of the <F5> mapping the OSV documentation suggests, for starting the debug server in the debugee
        OsvLaunch = {
          function (opts)
            require"osv".launch({port=tonumber(opts.fargs[1] or nlua_port)})
          end,
          nargs = "?",
          desc = "Launch OSV debug server",
        },
      },
    },
  }

}
