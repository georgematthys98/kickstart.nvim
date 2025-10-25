return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  keys = {
    {
      '<leader>dvo',
      function()
        local input = vim.fn.input('DiffviewOpen ')
        if input ~= '' then
          vim.cmd('DiffviewOpen ' .. input)
        else
          vim.cmd('DiffviewOpen')
        end
      end,
      desc = 'Diffview: open (prompt)',
      nowait = true,
      silent = true,
    },
    { '<leader>dvc', '<cmd>DiffviewClose<CR>', desc = 'Diffview: close', silent = true },
  },
  opts = {
    use_icons = true,
    view = {
      merge_tool = { layout = 'diff3_mixed' },
      default    = { layout = 'diff2_horizontal' },
    },
    enhanced_diff_hl = true,
    hooks = {
      view_opened = function()
        vim.cmd('setlocal foldmethod=manual')
      end,
    },
  },
}
