return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  cmd = "Copilot",
  opts = {
    panel = {
      enabled = false,
    },
    suggestion = {
      auto_trigger = true,
      hide_during_completion = false,
      keymap = {
        accept = "<Tab>",
        dismiss = "<C-]>",
      },
    },
    filetypes = {
      ["*"] = true,
      markdown = false,
      text = false,
      gitcommit = false,
    },
  },
}
