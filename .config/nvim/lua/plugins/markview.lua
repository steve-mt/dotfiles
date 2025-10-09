return {
    "OXY2DEV/markview.nvim",
    lazy = false,
    config = function()
        require("markview").setup()

        vim.keymap.set("n", "<leader>mv", "<cmd>Markview toggle<cr>", { desc = "Toggle Markview" })
    end,
}
