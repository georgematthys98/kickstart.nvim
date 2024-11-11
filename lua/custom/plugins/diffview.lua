return {
  "sindrets/diffview.nvim",
  config = function()
    vim.keymap.set('n', '<leader>dvo', function() require("diffview").open(vim.fn.input("DiffviewOpen ")) end, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>dvc", "<cmd>DiffviewClose<cr>", { noremap = true, silent = true })
    require('diffview').setup({
      hooks = {
        view_opened = function(view)
          vim.cmd("setlocal foldmethod=manual")  -- Disable folds by setting manual folding
        end
      }
    })
  end

}
