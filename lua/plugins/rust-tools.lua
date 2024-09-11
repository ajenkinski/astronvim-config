-- This is disabled because I'm using rust-pack.lua instead
if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  { 
    "simrat39/rust-tools.nvim",
    lazy = true,
  }, -- add lsp plugin
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      handlers = {
        -- add custom handler
        rust_analyzer = function(_, opts)
          opts = vim.tbl_deep_extend("force", opts, {
            settings = {
              -- to enable rust-analyzer settings visit:
              -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
              ["rust-analyzer"] = {
                -- Use clippy instead of check
                checkOnSave = {
                  command = "clippy",
                  -- Disable some checks
                  extraArgs = {
                    "--", "-A", "clippy::needless_range_loop"
                  }
                },
                inlayHints = {
                  chainingHints = {
                    enable = true,
                  },
                }
              }
            }
          })

          local extension_path, codelldb_path, liblldb_path
          local use_vs_codelldb = false

          if use_vs_codelldb then
            extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/'
            codelldb_path = extension_path .. 'adapter/codelldb'
            liblldb_path = extension_path .. 'lldb/lib/liblldb'
          else
            extension_path = vim.env.HOME .. '/.local/share/nvim/mason/packages/'
            codelldb_path = extension_path .. 'codelldb/extension/adapter/codelldb'
            liblldb_path = extension_path .. 'codelldb/extension/lldb/lib/liblldb'
          end

          local this_os = vim.loop.os_uname().sysname
          -- The liblldb extension is .so for linux and .dylib for macOS
          liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")

          -- change this to true to use nvim's builtin inlay hints instead of rust-tools'.
          local use_vim_inlay_hints = false

          require("rust-tools").setup {
            server = opts,
            dap = {
              adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path),
            },
            tools = {
              inlay_hints = {
                -- set this to true to use rust-tools' inlay hints
                auto = not use_vim_inlay_hints,
              },
            },
          }

          -- Disable vim 0.10.0's builtin inlay hints, since they duplicate rust-tools's version
          if not use_vim_inlay_hints and vim.lsp.inlay_hint then
            vim.api.nvim_create_autocmd({"FileType"}, {
              pattern = "rust",
              callback = function(event)
                vim.lsp.inlay_hint.enable(false, { bufnr = event.buf })
              end,
            })
          end
        end,
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "rust_analyzer" }, -- automatically install lsp
    },
  },
}
