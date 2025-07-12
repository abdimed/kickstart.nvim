return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local icons = {
      diagnostics = {
        Error = ' ',
        Warn = ' ',
        Info = ' ',
        Hint = ' ',
      },
      git = {
        added = ' ',
        modified = ' ',
        removed = ' ',
      },
    }

    local function get_root_dir()
      local clients = vim.lsp.get_active_clients { bufnr = 0 }
      if #clients > 0 and clients[1].config.root_dir then
        return vim.fn.fnamemodify(clients[1].config.root_dir, ':~')
      end
      return vim.fn.fnamemodify(vim.loop.cwd(), ':~')
    end

    local function pretty_path()
      local path = vim.api.nvim_buf_get_name(0)
      if path == '' then
        return '[No Name]'
      end
      return vim.fn.fnamemodify(path, ':~:.')
    end

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },

      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },

        lualine_c = {
          { get_root_dir, icon = '', separator = ' ' },
          {
            'diagnostics',
            symbols = icons.diagnostics,
          },
          { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
          { pretty_path },
        },

        lualine_x = {
          -- Noice command status
          {
            function()
              return require('noice').api.status.command.get()
            end,
            cond = function()
              return package.loaded['noice'] and require('noice').api.status.command.has()
            end,
            color = { fg = '#ff9e64' },
          },
          {
            function()
              return require('noice').api.status.mode.get()
            end,
            cond = function()
              return package.loaded['noice'] and require('noice').api.status.mode.has()
            end,
            color = { fg = '#9ece6a' },
          },

          -- DAP debugger status
          {
            function()
              return '  ' .. require('dap').status()
            end,
            cond = function()
              return package.loaded['dap'] and require('dap').status() ~= ''
            end,
            color = { fg = '#7aa2f7' },
          },

          -- Lazy updates
          {
            function()
              return require('lazy.status').updates()
            end,
            cond = function()
              return package.loaded['lazy'] and require('lazy.status').has_updates()
            end,
            color = { fg = '#e0af68' },
          },

          -- Git diff
          {
            'diff',
            symbols = icons.git,
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },

        lualine_y = {
          { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
          { 'location', padding = { left = 0, right = 1 } },
        },

        lualine_z = {
          function()
            return ' ' .. os.date '%R'
          end,
        },
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { pretty_path },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },

      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}
