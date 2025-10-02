return {
  "folke/snacks.nvim",
  lazy = false,
  opts = {
    lazygit = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = false }, -- we set this in options.lua
    words = { enabled = true },
    image = { enabled = true },
    terminal = { enabled = true },
  },
  keys = {
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit (cwd)",
    },
    {
      "<c-/>",
      function()
        Snacks.terminal(nil, { cwd = vim.fn.getcwd() })
      end,
      desc = "Terminal",
    },
    {
      "<C-/>",
      "<cmd>close<cr>",
      mode = "t",
      desc = "Hide Terminal",
    },
  },
}
