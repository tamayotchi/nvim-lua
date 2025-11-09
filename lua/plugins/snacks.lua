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
    explorer = { enabled = true },
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
      "<leader>e",
      function()
        Snacks.explorer()
      end,
      desc = "File Explorer",
    },
    {
      "<c-/>",
      function()
        Snacks.terminal(nil, { cwd = vim.fn.getcwd() })
      end,
      desc = "Terminal",
    },
    {
      "<c-_>",
      function()
        Snacks.terminal(nil, { cwd = vim.fn.getcwd() })
      end,
      desc = "which_key_ignore",
    },
    {
      "<C-/>",
      "<cmd>close<cr>",
      mode = "t",
      desc = "Hide Terminal",
    },
    {
      "<C-_>",
      "<cmd>close<cr>",
      mode = "t",
      desc = "which_key_ignore",
    },
  },
}
