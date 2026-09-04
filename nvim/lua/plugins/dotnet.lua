-- C#/.NET: Roslyn, tests, and debugging
local function has_dotnet_10(dotnet)
  if vim.fn.executable(dotnet) ~= 1 then
    return false
  end

  local result = vim.system({ dotnet, "--list-sdks" }, { text = true }):wait()
  return result.code == 0 and result.stdout:match("^10%.") ~= nil
end

local function roslyn_command()
  local server = vim.fs.joinpath(vim.env.HOME, ".dotnet", "tools", "roslyn-language-server")
  local args = {
    server,
    "--stdio",
    "--logLevel",
    "Information",
    "--telemetryLevel",
    "off",
  }

  if has_dotnet_10(vim.fn.exepath("dotnet")) then
    return args
  end

  -- Keep builds and tests on the normal dotnet while using an existing
  -- user-local SDK 10 to host the current Roslyn language server.
  local local_root = vim.fs.joinpath(vim.env.HOME, ".dotnet")
  if has_dotnet_10(vim.fs.joinpath(local_root, "dotnet")) then
    return vim.list_extend({
      "/usr/bin/env",
      "DOTNET_ROOT=" .. local_root,
      "PATH=" .. local_root .. ":" .. vim.env.PATH,
    }, args)
  end

  return args
end

return {
  {
    "seblyng/roslyn.nvim",
    lazy = false,
    opts = {},
    config = function(_, opts)
      vim.lsp.config("roslyn", {
        cmd = roslyn_command(),
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        settings = {
          ["csharp|completion"] = {
            dotnet_show_completion_items_from_unimported_namespaces = true,
          },
        },
      })
      require("roslyn").setup(opts)
    end,
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = { "nvim-neotest/nvim-nio" },
    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "Debug: Start/continue" },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step into" },
      { "<S-F11>", function() require("dap").step_out() end, desc = "Debug: Step out" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle breakpoint" },
      {
        "<leader>dB",
        function()
          local condition = vim.fn.input("Breakpoint condition: ")
          if condition ~= "" then
            require("dap").set_breakpoint(condition)
          end
        end,
        desc = "Debug: Conditional breakpoint",
      },
      { "<leader>dc", function() require("dap").continue() end, desc = "Debug: Start/continue" },
      { "<leader>de", function() require("dapui").eval() end, mode = { "n", "x" }, desc = "Debug: Evaluate" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Debug: Toggle REPL" },
      { "<leader>dx", function() require("dap").terminate() end, desc = "Debug: Terminate" },
    },
    config = function()
      local dap = require("dap")

      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticInfo", linehl = "Visual" })
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      { "<leader>du", function() require("dapui").toggle() end, desc = "Debug: Toggle UI" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      dap.listeners.before.attach.dotnet_dapui = function()
        dapui.open()
      end
      dap.listeners.before.launch.dotnet_dapui = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dotnet_dapui = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dotnet_dapui = function()
        dapui.close()
      end
    end,
  },

  {
    "GustavEikaas/easy-dotnet.nvim",
    cmd = "Dotnet",
    ft = { "cs", "razor" },
    dependencies = {
      "ibhagwan/fzf-lua",
      "mfussenegger/nvim-dap",
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>da", "<cmd>Dotnet debug<cr>", desc = ".NET: Debug project" },
      { "<leader>dA", "<cmd>Dotnet debug attach<cr>", desc = ".NET: Attach to process" },
      { "<leader>dp", "<cmd>Dotnet debug profile<cr>", desc = ".NET: Debug launch profile" },
      { "<space>d", "<cmd>Dotnet diagnostic<cr>", desc = ".NET: Workspace diagnostics" },
    },
    config = function()
      local easy_dotnet = require("easy-dotnet")

      easy_dotnet.setup({
        picker = "fzf",
        auto_bootstrap_namespace = false,
        csproj_mappings = false,
        fsproj_mappings = false,
        projx_lsp = {
          enabled = false,
        },
        debugger = {
          auto_register_dap = true,
          console = "integratedTerminal",
          engine = "netcoredbg",
          mem_cpu_usage = false,
        },
        lsp = {
          enabled = false,
        },
        test_runner = {
          auto_start_testrunner = false,
          neotest_integration = false,
        },
      })

    end,
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "GustavEikaas/easy-dotnet.nvim",
      "Issafalcon/neotest-dotnet",
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>tn", function() require("neotest").run.run() end, desc = "Test: Run nearest" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Test: Run file" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Test: Run last" },
      { "<leader>tN", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Test: Debug nearest" },
      {
        "<leader>tF",
        function() require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" }) end,
        desc = "Test: Debug file",
      },
      { "<leader>tL", function() require("neotest").run.run_last({ strategy = "dap" }) end, desc = "Test: Debug last" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Test: Show output" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Test: Toggle summary" },
      { "<leader>tw", "<cmd>NeotestSelectRunsettingsFile<cr>", desc = "Test: Select runsettings" },
      { "<leader>tx", function() require("neotest").run.stop() end, desc = "Test: Stop" },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-dotnet")({
            dap = {
              adapter_name = "easy-dotnet",
            },
            discovery_root = "project",
          }),
        },
      })
    end,
  },
}
