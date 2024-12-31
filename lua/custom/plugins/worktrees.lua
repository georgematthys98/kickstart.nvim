return {
  "ThePrimeagen/git-worktree.nvim",
  config = function ()
    require("telescope").load_extension("git_worktree")
    vim.keymap.set('n', '<leader>sw', function() require('telescope').extensions.git_worktree.git_worktrees() end, { desc = '[S]earch [W]orktrees' } )
    vim.keymap.set('n', '<leader>cw', function() require('telescope').extensions.git_worktree.create_git_worktree() end, { desc = '[S]earch [W]orktrees' } )
  end,
}
