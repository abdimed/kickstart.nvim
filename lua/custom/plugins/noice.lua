return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        signature = { enabled = true },
        hover = { enabled = true },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      {
        'rcarriga/nvim-notify',
        config = function()
          require('notify').setup {
            background_colour = '#1e1e2e',
          }
          vim.notify = require 'notify' -- override default vim.notify
        end,
      },
    },
  },
}
