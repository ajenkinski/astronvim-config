-- set vim options here (vim.<first_key>.<second_key> = value)
return {
  opt = {
    expandtab = true,
  },
  g = {
    neovide_cursor_animation_length = 0.01,
    neovide_scroll_animation_length = 0.1,

    -- Explicitly specify python to use for neovim's python3 provider.  Without this, startup time is slow
    -- because it searches for a suitable installation.  If this virtualenv goes away, it could also cause
    -- slowdown, because then nvim might go back to search for a valid installation.  Can also entirely disable
    -- python3 provider with:
    -- loaded_python3_provider = 0,
    -- See ":help provider-python" for more info
    python3_host_prog = "/Users/ajenkins/Envs/nvim-plugins/bin/python",
  }
}
-- If you need more control, you can use the function()...end notation
-- return function(local_vim)
--   local_vim.opt.relativenumber = true
--   local_vim.g.mapleader = " "
--   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
--   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
--
--   return local_vim
-- end
