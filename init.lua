return {
    colorscheme = "catppuccin",

    lsp = {
        formatting = {
            format_on_save = {
                enabled = true,
                ignore_filetypes = { -- disable format-on-save for some filetypes
                    "bzl",
                }
            },
        },
        -- Names of LSP servers that aren't installed by mason
        servers = {
            "please",
        },
        -- each key in config is an LSP server name, with the value being a table, or function that returns a table,
        -- to override defaults for that lsp server.  See ":help lspconfig-setup" to see what options can go in
        -- each config.
        -- See ":help lspconfig-root-detection" for info on the lspconfig.util functions.
        config = {
            please = function()
                return {
                    cmd = { 'plz', 'tool', 'lps' },
                    filetypes = { "bzl" },
                    root_dir = require("lspconfig.util").root_pattern(".plzconfig")
                }
            end,

            terraformls = {
                -- Without this, it uses compass/ as the root directory, treating all .tf files
                -- in compass as if they're part of the same module.
                root_dir = function(startpath)
                    local utils = require('lspconfig.util')

                    local function matcher(path)
                        if utils.path.is_dir(path) then
                            -- If path contains a BUILD file, or path/.. doesn't contain any .tf files, then path is root_dir
                            if utils.path.is_file(utils.path.join(path, 'BUILD')) then
                                return path
                            end
                            local tf_pat = utils.path.join(utils.path.escape_wildcards(utils.path.dirname(path)), "*.tf")
                            if #vim.fn.glob(tf_pat) == 0 then
                                return path
                            end
                        end
                    end

                    startpath = utils.strip_archive_subpath(startpath)
                    return utils.search_ancestors(startpath, matcher)
                end
            }
        },
        -- These allow further modification to language server configs.  Keys are LSP server names, and values are a function that takes
        -- (lsp_server_name, config), where config is the config table for that server, after possibly being modified by the config table
        -- above.
        setup_handlers = {
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
                            }
                        }
                    }
                })

                require("rust-tools").setup {
                    -- Do rust-tools config opts here instead of in plugins section, because
                    -- we need access to server opts from rust_analyzer
                    server = opts,
                    dap = {
                        adapter = {
                            type = "server",
                            port = "${port}",
                            executable = {
                                command = "codelldb",
                                args = { "--port", "${port}" }
                            },
                            name = "rt_lldb"
                        }
                    }
                }
            end
        }
    },

    -- The polish function runs after all other config, and allows running any arbitrary code that doesn't fit into the other
    -- config categories.
    polish = function()
        vim.filetype.add({
            filename = {
                ['BUILD'] = 'bzl',
            },
            extension = {
                build_defs = 'bzl',
                lalrpop = 'lalrpop'
            }
        })

        -- Nvim by default maps <C-k> to switch to the next window.  Unmap it in terminal mode so it can
        -- delete to end of line
        vim.keymap.del('t', '<C-k>')

        -- Set wezterm tab title to the filename of the current buffer
        vim.api.nvim_create_autocmd({"BufEnter"}, {
            callback = function(event)
                local title = "vim"
                if event.file ~= "" then
                    title = string.format("vim: %s", vim.fs.basename(event.file))
                end

                vim.fn.system({"wezterm", "cli", "set-tab-title", title})
            end,
        })

        vim.api.nvim_create_autocmd({"VimLeave"}, {
            callback = function()
                vim.fn.system({"wezterm", "cli", "set-tab-title", ""})
            end,
        })
    end
}
