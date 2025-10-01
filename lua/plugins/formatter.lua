local mason = "williamboman/mason.nvim"
local conform = "stevearc/conform.nvim"

return {
  {
    conform,
    cmd = { "ConformInfo" },
    opts = {
      formatters = {
        stylua = {
          prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        },
      },
      formatters_by_ft = {
        cpp = { "clang-format" },
        html = { "prettierd" },
        json = { "jq" },
        lua = { "stylua" },
        typescript = { "eslint_d", "prettierd" },
        yaml = { "prettierd" },
      },
    },
    keys = {
      {
        "<leader>fb",
        function()
          require("conform").format()
        end,
        "[f]ormat [b]uffer",
      },
    },
  },
  {
    "zapling/mason-conform.nvim",
    dependencies = { mason, conform },
    opts = {
      automatic_installation = false, -- Mason handles installation centrally
    },
  },
}
