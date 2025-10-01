return {

  -- Treesitter is a new parser generator tool that we can
  -- use in Neovim to power faster and more accurate
  -- syntax highlighting.
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
    },
    config = function(_, opts)
      local TS = require("nvim-treesitter")

      -- Sanity checks
      if not TS.setup then
        vim.notify("Please update nvim-treesitter", vim.log.levels.ERROR)
        return
      elseif type(opts.ensure_installed) ~= "table" then
        vim.notify("nvim-treesitter opts.ensure_installed must be a table", vim.log.levels.ERROR)
        return
      end

      -- Setup treesitter
      TS.setup(opts)

      -- Install missing parsers
      local installed = TS.get_installed and TS.get_installed() or {}
      local to_install = vim.tbl_filter(function(lang)
        return not vim.tbl_contains(installed, lang)
      end, opts.ensure_installed or {})

      if #to_install > 0 then
        vim.schedule(function()
          TS.install(to_install, { summary = true })
        end)
      end

      -- Auto-enable features per filetype
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_attach", { clear = true }),
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(ev.match)
          if not lang then
            return
          end

          -- Check if parser is available
          local has_parser = pcall(vim.treesitter.language.add, lang)
          if not has_parser then
            return
          end

          -- Enable highlighting
          if opts.highlight and opts.highlight.enable then
            pcall(vim.treesitter.start, ev.buf)
          end

          -- Enable indents
          if opts.indent and opts.indent.enable then
            -- Check if indent queries exist
            local has_indents = pcall(vim.treesitter.query.get, lang, "indents")
            if has_indents then
              vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter.indent'.get_indent(v:lnum)"
            end
          end

          -- Enable folds (optional, can be enabled if you want treesitter-based folding)
          -- Uncomment if you want treesitter folds
          -- local has_folds = pcall(vim.treesitter.query.get, lang, "folds")
          -- if has_folds then
          --   vim.wo[0].foldmethod = "expr"
          --   vim.wo[0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          -- end
        end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      -- Setup keymaps for textobject movements
      local moves = {
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]c"] = "@class.outer",
          ["]a"] = "@parameter.inner",
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
          ["]C"] = "@class.outer",
          ["]A"] = "@parameter.inner",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[c"] = "@class.outer",
          ["[a"] = "@parameter.inner",
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
          ["[C"] = "@class.outer",
          ["[A"] = "@parameter.inner",
        },
      }

      for method, keymaps in pairs(moves) do
        for key, query in pairs(keymaps) do
          local desc = query:gsub("@", ""):gsub("%..*", "")
          desc = desc:sub(1, 1):upper() .. desc:sub(2)
          desc = (key:sub(1, 1) == "[" and "Prev " or "Next ") .. desc
          desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and " End" or " Start")

          vim.keymap.set({ "n", "x", "o" }, key, function()
            -- Lazy load the move module when actually used
            require("nvim-treesitter-textobjects.move")[method](query)
          end, {
            desc = desc,
            silent = true,
          })
        end
      end
    end,
  },

  -- Automatically add closing tags for HTML and JSX
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
}
