--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- Additional Plugins
lvim.plugins = {
  -- Themes
  {"morhetz/gruvbox"},
  {"sainnhe/gruvbox-material"},
  {"sainnhe/everforest"},
  {"NLKNguyen/papercolor-theme"},
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end,
  },
--     {
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
  -- Rust
  "simrat39/rust-tools.nvim",
  {
    "saecki/crates.nvim",
    version = "v0.3.0",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup {
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
        popup = {
          border = "rounded",
        },
      }
    end,
  },
  -- Debugging
  {"jay-babu/mason-nvim-dap.nvim"},
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = {
      -- "mfusseneger/nvim-dap",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("nvim-dap-virtual-text").setup {
        enabled = true,                        -- enable this plugin (the default)
        enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
        highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
        show_stop_reason = true,               -- show stop reason when stopped for exceptions
        commented = false,                     -- prefix virtual text with comment string
        only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
        all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
        --- A callback that determines how a variable is displayed or whether it should be omitted
        --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
        --- @param buf number
        --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
        --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
        --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
        display_callback = function(variable, _buf, _stackframe, _node)
          return variable.name .. ' = ' .. variable.value
        end,

        -- experimental features:
        virt_text_pos = 'eol',                 -- position of virtual text, see `:h nvim_buf_set_extmark()`
        all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
        virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
        virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
                                               -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
      }
    end,
  },
  -- Python venv switcher
  {"ChristianChiarulli/swenv.nvim"},
  -- Debugging Python
  {"mfussenegger/nvim-dap-python"},
  {"nvim-neotest/neotest"},
  {"nvim-neotest/neotest-python"},
}

require("clangd_extensions_config").config()

-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
-- lvim.colorscheme = "lunar"
lvim.colorscheme = "gruvbox"
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- My personal vim options:
vim.opt.guifont = "monospace:h11"  -- To get a decent font size when using Neovide (by default the fonts are way too big)
lvim.keys.insert_mode = {
  ["jk"] = "<Esc>",  -- Better way to exit normal mode
}

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- lvim.keys.normal_mode["<C-S>"] = ":wa<cr>" ---> This does NOT work because the program interprets uppercase and lowercase as the same for some reason...
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<Tab>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-Tab>"] = ":BufferLineCyclePrev<CR>"
-- better paste:
lvim.keys.normal_mode["<Leader>p"] = "\"0p"
lvim.keys.normal_mode["<Leader>P"] = "\"0P"
lvim.keys.visual_mode["<Leader>p"] = "\"0p"
--
-- Debugging
lvim.keys.normal_mode["<F5>"] = ":lua require('dap').continue()<CR>"
lvim.keys.normal_mode["<F10>"] = ":lua require('dap').step_over()<CR>"
lvim.keys.normal_mode["<F11>"] = ":lua require('dap').step_into()<CR>"
lvim.keys.normal_mode["<F12>"] = ":lua require('dap').step_out()<CR>"
lvim.keys.normal_mode["<F6>"] = ":lua require('dap.ui.widgets').hover()<CR>"
lvim.keys.normal_mode["<Leader>dT"] = ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>"
-- The following don't work...
-- lvim.keys.normal_mode["<F7>"] = ":lua require('dap.ui.variables').hover()<CR>"
-- lvim.keys.normal_mode["<F8>"] = ":lua require('dap.ui.variables').visual_hover()<CR>"

-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Change theme settings
-- lvim.builtin.theme.options.dim_inactive = true
-- lvim.builtin.theme.options.style = "storm"

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "cpp",
  "cmake",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "toml",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- generic LSP settings

-- make sure server will always be installed even if the server is in skipped_servers list
lvim.lsp.installer.setup.ensure_installed = {
    -- "sumneko_lua",
    "jsonls",
    "clangd",
    "pyright",
    "rust_analyzer",
    "lua_ls",
}
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "stylua", filetypes = { "lua" } },
  { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
}

-- -- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
}

-- Dap adapter configuations
require("mason-nvim-dap").setup({
    ensure_installed = {
      "codelldb",
      "debugpy",
    }
})

-- For debugging C/C++/Rust (codelldb):
local dap_ok, dap = pcall(require, "dap")
  if not (dap_ok) then
    print("nvim-dap not installed!")
  return
end

local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")

-- debugpy for debugging Python
lvim.builtin.dap.active = true -- What does this do???
pcall(function()
  require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)

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
  dap_local.configurations.rust = dap_config_codelldb
  dap_local.configurations.c = dap_config_codelldb
  dap_local.configurations.cpp = dap_config_codelldb
end

-- Configuration for LSP servers

-- pyright (Python)
local on_pyright_attach = function ()
  -- Testing
  --
  require("neotest").setup({
    adapters = {
      require("neotest-python")({
        -- Extra arguments for nvim-dap configuration
        -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
        dap = {
          justMyCode = false,
          console = "integratedTerminal",
        },
        args = { "--log-level", "DEBUG", "--quiet" },
        runner = "pytest",
      })
    }
  })

  -- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
  local wk_ok, which_key_plugin = pcall(require, "which-key")
    if not (wk_ok) then
      print("Which Key not installed!")
    return
  end

  which_key_plugin.register({
    C = {
      name = "Python", -- optional group name
      c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" }, -- binding for switching venv
    },
    d = {
      m = {
        "<cmd>lua require('neotest').run.run()<cr>",
        "Test Method"
      },
      M = {
        "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
        "Test Method DAP"
      },
      f = {
        "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>",
        "Test Class"
      },
      F = {
        "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
        "Test Class DAP"
      },
      S = {
        "<cmd>lua require('neotest').summary.toggle()<cr>",
        "Test Summary"
      },
    },
  }, { prefix = "<leader>" })
end

local on_rust_analyzer_attach = function ()
  lldb_dap_configs_setup()
  vim.api.nvim_set_keymap("n", "<m-d>", "<cmd>RustOpenExternalDocs<Cr>", { noremap = true, silent = true })

  lvim.builtin.which_key.mappings["C"] = {
    name = "Rust",
    r = { "<cmd>RustRunnables<Cr>", "Runnables" },
    t = { "<cmd>lua _CARGO_TEST()<cr>", "Cargo Test" },
    m = { "<cmd>RustExpandMacro<Cr>", "Expand Macro" },
    c = { "<cmd>RustOpenCargo<Cr>", "Open Cargo" },
    p = { "<cmd>RustParentModule<Cr>", "Parent Module" },
    d = { "<cmd>RustDebuggables<Cr>", "Debuggables" },
    v = { "<cmd>RustViewCrateGraph<Cr>", "View Crate Graph" },
    R = {
      "<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<Cr>",
      "Reload Workspace",
    },
    o = { "<cmd>RustOpenExternalDocs<Cr>", "Open External Docs" },
    y = { "<cmd>lua require'crates'.open_repository()<cr>", "[crates] open repository" },
    P = { "<cmd>lua require'crates'.show_popup()<cr>", "[crates] show popup" },
    i = { "<cmd>lua require'crates'.show_crate_popup()<cr>", "[crates] show info" },
    f = { "<cmd>lua require'crates'.show_features_popup()<cr>", "[crates] show features" },
    D = { "<cmd>lua require'crates'.show_dependencies_popup()<cr>", "[crates] show dependencies" },
  }
end

local lspconfig = require('lspconfig')
lspconfig.pyright.setup {
  on_attach = on_pyright_attach,
}

pcall(function()
  require("rust-tools").setup {
    tools = {
      executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
      reload_workspace_from_cargo_toml = true,
      runnables = {
        use_telescope = true,
      },
      inlay_hints = {
        auto = true,
        only_current_line = false,
        show_parameter_hints = false,
        parameter_hints_prefix = "<-",
        other_hints_prefix = "=>",
        max_len_align = false,
        max_len_align_padding = 1,
        right_align = false,
        right_align_padding = 7,
        highlight = "Comment",
      },
      hover_actions = {
        border = "rounded",
      },
      on_initialized = function()
        vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
          pattern = { "*.rs" },
          callback = function()
            local _, _ = pcall(vim.lsp.codelens.refresh)
          end,
        })
      end,
    },
    dap = {
      adapter = codelldb_adapter,
    },
    server = {
      on_attach = function(client, bufnr)
        require("lvim.lsp").common_on_attach(client, bufnr)
        on_rust_analyzer_attach()
        local rt = require "rust-tools"
        vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
      end,

      capabilities = require("lvim.lsp").common_capabilities(),
      settings = {
        ["rust-analyzer"] = {
          lens = {
            enable = true,
          },
          checkOnSave = {
            enable = true,
            command = "clippy",
          },
        },
      },
    },
  }
end)


-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })


