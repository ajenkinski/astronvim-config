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

-- Open a project in a new vim tab.  For now this just means setting the tab's cwd to the specified
-- directory, but I could expand it to do more.
vim.api.nvim_create_user_command('ProjectOpen', 'tabnew +tcd\\ <args>', {
  nargs = 1,
  complete = 'dir',
})

-- Set wezterm tab title to the filename of the current buffer
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

