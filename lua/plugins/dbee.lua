return {
  "kndndrj/nvim-dbee",
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- "nvim-lua/plenary.nvim",
  },
  build = function()
    require("dbee").install()
  end,
  keys = {
    {
      "<leader>db",
      function()
        require("dbee").toggle()
      end,
      desc = "Toggle dbee",
    },
  },
  config = function()
    local dbee = require("dbee")
    local sources = require("dbee.sources")

    local connections_path = vim.fn.stdpath("config") .. "/dbee/connections.json"
    vim.fn.mkdir(vim.fn.fnamemodify(connections_path, ":h"), "p")

    dbee.setup({
      sources = {
        sources.FileSource:new(connections_path),
      },
    })
  end,
}
