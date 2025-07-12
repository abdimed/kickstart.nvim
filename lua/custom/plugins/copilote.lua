return {
  'github/copilot.vim',
  lazy = false, -- load on startup
  config = function()
    vim.g.copilot_enabled = false

    -- Define the toggle function
    function ToggleCopilot()
      if vim.g.copilot_enabled then
        vim.g.copilot_enabled = false
        vim.cmd 'Copilot disable'
        print 'Copilot Disabled'
      else
        vim.g.copilot_enabled = true
        vim.cmd 'Copilot enable'
        print 'Copilot Enabled'
      end
    end

    -- Set keymap: <leader>i c
    vim.api.nvim_set_keymap('n', '<leader>ic', [[:lua ToggleCopilot()<CR>]], { noremap = true, silent = true })
  end,
}
