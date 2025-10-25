return {
  {
    'sainnhe/sonokai',
    init = function()
      vim.cmd.colorscheme 'sonokai'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
