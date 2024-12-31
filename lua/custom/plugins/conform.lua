return { -- Autoformat
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format({ async = true, lsp_fallback = true }, function(err, did_edit)
          if err ~= nil then
            print('Failed with error:' .. err)
          elseif did_edit then
            print 'Successfully editted the file'
          else
            print 'No formatting required'
          end
        end)
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    stop_after_first = true,
    notify_on_error = false,
    format_on_save = false,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      python = { 'black' },
      javascript = { 'prettierd', 'prettier' },
      typescript = { 'prettierd', 'prettier' },
      json = { 'prettier', 'prettierd' },
      rust = { 'rustfmt', lsp_format = 'fallback' },
      html = { 'prettierd', 'prettier' },
      css = { 'prettier' },
      svelte = { 'prettier', 'prettierd' },
      toml = { 'taplo' },
    },
  },
}
