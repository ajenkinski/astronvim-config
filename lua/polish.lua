-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

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
-- Turns out this is unneeded, because the vim `title` and `titleold` options can do this.
-- See `:help title` for more info.
-- vim.api.nvim_create_autocmd({"BufEnter"}, {
--     callback = function(event)
--         local title = "vim"
--         if event.file ~= "" then
--             title = string.format("vim: %s", vim.fs.basename(event.file))
--         end
--
--         vim.fn.system({"wezterm", "cli", "set-tab-title", title})
--     end,
-- })
--
-- vim.api.nvim_create_autocmd({"VimLeave"}, {
--     callback = function()
--         vim.fn.system({"wezterm", "cli", "set-tab-title", ""})
--     end,
-- })

