return {
  {
    'benlubas/molten-nvim',
    version = '^1.0.0', -- use version <2.0.0 to avoid breaking changes
    dependencies = { '3rd/image.nvim' },
    build = ':UpdateRemotePlugins',
    events = { 'VeryLazy' },
    init = function()
      vim.g.molten_output_virt_lines = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_auto_open_output = false
      -- vim.keymap.set('n', '<localleader>mi', ':MoltenInit<CR>', { silent = true, desc = 'Initialize the plugin' })
      -- vim.keymap.set('n', '<localleader>me', ':MoltenEvaluateOperator<CR>', { silent = true, desc = 'run operator selection' })
      -- vim.keymap.set('n', '<localleader>rl', ':MoltenEvaluateLine<CR>', { silent = true, desc = 'evaluate line' })
      -- vim.keymap.set('n', '<localleader>rr', ':MoltenReevaluateCell<CR>', { silent = true, desc = 're-evaluate cell' })
      -- vim.keymap.set('v', '<localleader>r', ':<C-u>MoltenEvaluateVisual<CR>gv', { silent = true, desc = 'evaluate visual selection' })
      -- vim.keymap.set('n', '<localleader>os', ':MoltenShowOutput<CR>:noautocmd MoltenEnterOutput<CR>', { silent = true, desc = 'show/enter output' })
      vim.g.molten_image_provider = 'image.nvim'
      vim.g.molten_output_win_max_height = 20
    end,
    keys = {
      { '<localleader>mi', ':MoltenInit<CR>', desc = 'Initialize the plugin', silent = true },
      { '<localleader>me', ':MoltenEvaluateOperator<CR>', desc = 'Run operator selection', silent = true },
      { '<localleader>rl', ':MoltenEvaluateLine<CR>', desc = 'Evaluate line', silent = true },
      { '<localleader>rr', ':MoltenReevaluateCell<CR>', desc = 'Re-evaluate cell', silent = true },
      { '<localleader>r', ':<C-u>MoltenEvaluateVisual<CR>gv', mode = 'v', desc = 'Evaluate visual selection', silent = true },
      { '<localleader>os', ':MoltenShowOutput<CR>:noautocmd MoltenEnterOutput<CR>', desc = 'Show/enter output', silent = true },
    },
  },
  {
    -- see the image.nvim readme for more information about configuring this plugin
    '3rd/image.nvim',
    lazy = true,
    opts = {
      backend = 'kitty', -- whatever backend you would like to use
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
    },
  },
}
