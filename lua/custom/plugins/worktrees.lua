return {
  'polarmutex/git-worktree.nvim',
  lazy = true,
  init = function()
    require('telescope').load_extension 'git_worktree'
    vim.keymap.set('n', '<leader>sr', '<cmd>lua require("telescope").extensions.git_worktree.git_worktree()<cr>', { desc = 'Toggle UndoTree' })
    -- vim.keymap.set("n", "<leader>sr", "<cmd>lua require('git-worktree').switch_worktree()<cr>")
    local Hooks = require 'git-worktree.hooks'
    local config = require 'git-worktree.config'
    local update_on_switch = Hooks.builtins.update_current_buffer_on_switch

    Hooks.register(Hooks.type.SWITCH, function(path, prev_path)
      vim.notify('Moved from ' .. prev_path .. ' to ' .. path)
      update_on_switch(path, prev_path)

      -- Source the .nvim.lua from the *new* worktree root
      local nvim_lua_path = path .. '/.nvim.lua'
      if vim.fn.filereadable(nvim_lua_path) == 1 then
        vim.cmd('source ' .. vim.fn.fnameescape(nvim_lua_path))
        vim.notify('Sourced ' .. nvim_lua_path)
      else
        vim.notify('.nvim.lua not found in ' .. path, vim.log.levels.WARN)
      end
    end)

    Hooks.register(Hooks.type.DELETE, function()
      vim.cmd(config.update_on_change_command)
    end)
  end,
}
