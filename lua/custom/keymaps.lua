return {
  vim.keymap.set({ 'n', 'i', 'v' }, '<C-s>', '<cmd>w<cr>', { desc = 'Save file' }),
  vim.keymap.set('n', '<leader>gb', function()
    require('gitsigns').toggle_current_line_blame()
  end, { desc = 'Toggle Git Blame' }),
}
