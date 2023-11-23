local M = {}

vim.list_extend(lvim.plugins, {"p00f/clangd_extensions.nvim"})

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "clangd" })

local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")

-- codelldb allows debugging C/C++/Rust
local codelldb_adapter = {
  name = "codelldb",
  type = "server",
  port = "${port}",
  executable = {
    command = mason_path .. "bin/codelldb",
    args = { "--port", "${port}" },
    -- On windows you may have to uncomment this:
    -- detached = false,
  },
}

local dap_config_codelldb = {
  {
    name = "Launch codelldb 4 C/C++/Rust",
    type = "codelldb", -- matches the adapter
    request = "launch", -- could also attach to a currently running process
    program = function()
      return vim.fn.input(
        "Path to executable: ",
        vim.fn.getcwd() .. "/",
        "file"
      )
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
  },
}

local function lldb_dap_configs_setup()
  local dap_local = require('dap')
  dap_local.adapters.codelldb = codelldb_adapter
  -- dap_local.configurations.rust = dap_config_codelldb
  dap_local.configurations.c = dap_config_codelldb
  dap_local.configurations.cpp = dap_config_codelldb
end

local on_clangd_attach = function()
  -- Keymap to switch between source and header
  vim.api.nvim_set_keymap("n", "<Leader>lh", "<cmd>:ClangdSwitchSourceHeader<Cr>", { noremap = true, silent = true })
  -- If the 'go to definition' command does not work, it is probably because
  -- 'compile_commands.json' must be generated in the project root directory
  -- (see https://clang.llvm.org/docs/JSONCompilationDatabase.html ).
  -- The 'bear' tool can be used to generate it. It can be installed normally via the distro repos.
  -- In order to use it, start from a clean build, then call 'bear -- make' 
  -- (or whatever command is used to build instead of 'make').
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references)
  lldb_dap_configs_setup()
end

local lspconfig = require('lspconfig')
lspconfig.clangd.setup {
  on_attach = on_clangd_attach,
}

M.config = function()
  require("clangd_extensions").setup {
      server = {
          -- options to pass to nvim-lspconfig
          -- i.e. the arguments to require("lspconfig").clangd.setup({})
        on_attach = on_clangd_attach,
      },
      extensions = {
          -- defaults:
          -- Automatically set inlay hints (type hints)
          autoSetHints = true,
          -- These apply to the default ClangdSetInlayHints command
          inlay_hints = {
              inline = vim.fn.has("nvim-0.10") == 1,
              -- Options other than `highlight' and `priority' only work
              -- if `inline' is disabled
              -- Only show inlay hints for the current line
              only_current_line = false,
              -- Event which triggers a refersh of the inlay hints.
              -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
              -- not that this may cause  higher CPU usage.
              -- This option is only respected when only_current_line and
              -- autoSetHints both are true.
              only_current_line_autocmd = "CursorHold",
              -- whether to show parameter hints with the inlay hints or not
              show_parameter_hints = true,
              -- prefix for parameter hints
              parameter_hints_prefix = "<- ",
              -- prefix for all the other hints (type, chaining)
              other_hints_prefix = "=> ",
              -- whether to align to the length of the longest line in the file
              max_len_align = false,
              -- padding from the left if max_len_align is true
              max_len_align_padding = 1,
              -- whether to align to the extreme right or not
              right_align = false,
              -- padding from the right if right_align is true
              right_align_padding = 7,
              -- The color of the hints
              highlight = "Comment",
              -- The highlight group priority for extmark
              priority = 100,
          },
          ast = {
              -- These are unicode, should be available in any font
              role_icons = {
                   type = "🄣",
                   declaration = "🄓",
                   expression = "🄔",
                   statement = ";",
                   specifier = "🄢",
                   ["template argument"] = "🆃",
              },
              kind_icons = {
                  Compound = "🄲",
                  Recovery = "🅁",
                  TranslationUnit = "🅄",
                  PackExpansion = "🄿",
                  TemplateTypeParm = "🅃",
                  TemplateTemplateParm = "🅃",
                  TemplateParamObject = "🅃",
              },
              --[[ These require codicons (https://github.com/microsoft/vscode-codicons)
              role_icons = {
                  type = "",
                  declaration = "",
                  expression = "",
                  specifier = "",
                  statement = "",
                  ["template argument"] = "",
              },

              kind_icons = {
                  Compound = "",
                  Recovery = "",
                  TranslationUnit = "",
                  PackExpansion = "",
                  TemplateTypeParm = "",
                  TemplateTemplateParm = "",
                  TemplateParamObject = "",
              }, ]]

              highlights = {
                  detail = "Comment",
              },
          },
          memory_usage = {
              border = "none",
          },
          symbol_info = {
              border = "none",
          },
      },
  }
end

return M
