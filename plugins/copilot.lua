return {
  {
    "github/copilot.vim",
    enabled = true,
    lazy = false,
    config = function()
      vim.keymap.set('i', '<C-C>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false
      })
      vim.g.copilot_no_tab_map = true
      -- disable copilot for some filetypes
      vim.g.copilot_filetypes = {
        markdown = false,
      }
    end,
  },

}
