if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- After spending time figuring out how to get rustaceanvim working with AstroNvim,
-- I discovered that the astrocommunity rust pack already does this.  So I'm 
-- leaving this disabled and just using the community rust pack instead.  See 
-- ../community.lua

return {
  -- https://github.com/mrcjkb/rustaceanvim
  -- This is replacing rust-tools.nvim
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function() 
      vim.g.rustaceanvim = {
            server = {
              default_settings = {
                ["rust-analyzer"] = {
                  inlayHints = {
                    chainingHints = {
                      enable = true,
                    },
                  },
                },
              }
            },
          }
    end,
  },
  {
    "AstroNvim/astrolsp",
    opts = {
      handlers = {
        -- Disable rust_analyzer here because it's being setup by rustaceanvim, and lspconfig and rustaceanvim conflict.
        -- See `:h rustaceanvim.mason`
        -- set to false to disable the setup of a language server
        rust_analyzer = function(_, opts)
          -- While I want to let rustaceanvim initialize rust-analyzer, I still want to get the keybindings and other stuff
          -- that astrolsp sets up in its on_attach.  I need to use an autocmd instead of setting vim.g.rustaceanvim.server.on_attach,
          -- because setting the variable here is too late.
          if opts.on_attach then
            vim.api.nvim_create_autocmd({"LspAttach"}, {
              callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client.name == "rust-analyzer" then
                  opts.on_attach(client, args.buf)
                end
              end
            })
          end
        end,
      },
    },
  },
}
