return {
  "folke/snacks.nvim",
  lazy = false,
  opts = {
    lazygit = { enabled = true },
  },
  keys = {
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit (cwd)",
    },
  },
}
