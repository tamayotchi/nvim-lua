local mason = "williamboman/mason.nvim"
local nvim_lint = "mfussenegger/nvim-lint"

return {
  {
    nvim_lint,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("lint").linters_by_ft = {
        typescript = { "eslint_d" },
        json = { "jsonlint" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
  {
    "rshkarin/mason-nvim-lint",
    dependencies = { mason, nvim_lint, "williamboman/mason-lspconfig.nvim" },
    opts = {
      automatic_installation = false, -- Mason handles installation centrally
    },
  },
}
