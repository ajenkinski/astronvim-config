-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Nvim by default maps <C-k> to switch to the next window.  Unmap it in terminal mode so it can
-- delete to end of line
vim.keymap.del('t', '<C-k>')
