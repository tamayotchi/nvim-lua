return {
  "github/copilot.vim",
  event = "InsertEnter",
  init = function()
    -- Disable default <Tab> mapping, we use custom keys below
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_filetypes = {
      ["*"] = true,
      markdown = false,
      text = false,
      gitcommit = false,
    }
  end,
  config = function()
    vim.keymap.set(
      "i",
      "<Tab>",
      'copilot#Accept("<CR>")',
      { silent = true, expr = true, replace_keycodes = false, desc = "Copilot: accept suggestion" }
    )
    vim.keymap.set("i", "<C-]>", "<Plug>(copilot-dismiss)", { desc = "Copilot: dismiss suggestion" })
  end,
}
