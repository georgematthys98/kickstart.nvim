return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VeryLazy',
  config = function()
    require('lualine').setup {
      sections = {
        lualine_a = {
          {
            'mode',
            upper = true,
          },
        },
        lualine_b = {
          {
            'filename',
            file_status = true,
            path = 1,
          },
        },
        lualine_c = {
          {
            'branch',
            icon = '',
          },
        },
      },
    }
  end,
}
