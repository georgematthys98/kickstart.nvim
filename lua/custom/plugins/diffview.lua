return {
  "sindrets/diffview.nvim",
  config = function()
    vim.keymap.set('n', '<leader>dvo', function() require("diffview").open(vim.fn.input("DiffviewOpen ")) end, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>dvc", "<cmd>DiffviewClose<cr>", { noremap = true, silent = true })
  end

}
