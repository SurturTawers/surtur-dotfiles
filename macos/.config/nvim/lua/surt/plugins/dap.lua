return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local daps_path = "/Users/david/daps/"
    --local dap_python = require("dap-python")

    require("dapui").setup({
      layouts = {
        {
          elements = {
            {
              id = "breakpoints",
              size = 0.2,
            },
            {
              id = "scopes",
              size = 0.6,
            },
            {
              id = "stacks",
              size = 0.1,
            },
            {
              id = "watches",
              size = 0.1,
            },
          },
          position = "right",
          size = 100,
        },
        {
          elements = {
            {
              id = "repl",
              size = 0.5,
            },
            {
              id = "console",
              size = 0.5,
            },
          },
          position = "bottom",
          size = 10,
        },
      },
    })
    require("nvim-dap-virtual-text").setup({
      commented = true, -- Show virtual text alongside comment
    })

    --[[ LUA --]]
    dap.adapters["local-lua"] = {
      type = "executable",
      command = "node",
      args = {
        daps_path .. "local-lua-debugger-vscode/extension/debugAdapter.js",
      },
      enrich_config = function(config, on_config)
        if not config["extensionPath"] then
          local c = vim.deepcopy(config)
          -- 💀 If this is missing or wrong you'll see
          -- "module 'lldebugger' not found" errors in the dap-repl when trying to launch a debug session
          c.extensionPath = daps_path .. "local-lua-debugger-vscode/"
          on_config(c)
        else
          on_config(config)
        end
      end,
    }
    dap.configurations.lua = {
      {
        name = "Current file (local-lua-dbg, lua)",
        type = "local-lua",
        request = "launch",
        cwd = "${workspaceFolder}",
        program = {
          lua = "lua5.4",
          file = "${file}",
        },
        args = {},
      },
    }
    --[[  --]]

    --[[ JS --]]
    require("dap").adapters["pwa-node"] = {
      type = "server",
      host = "::1",
      port = "${port}",
      executable = {
        command = "node",
        -- 💀 Make sure to update this path to point to your installation
        args = { daps_path .. "js-debug/src/dapDebugServer.js", "${port}" },
      },
    }
    require("dap").configurations.javascript = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Debug Dockerized Node.js",
        port = 9229,                       -- Port exposed by the Node.js debugger in the container
        skipFiles = { "<node_internals>/**" }, -- Skip Node.js internal files
        sourceMaps = true,                 -- Enable source maps for debugging
        localRoot = "${workspaceFolder}",  -- Path to the app on the local machine
        remoteRoot = "/",                  -- Path to the app inside the container
        restart = true,                    -- Automatically restart debugging if the process restarts
        --protocol = "inspector",     -- Use the Node.js inspector protocol
      },
    }
    --[[ --]]

    --[[ PHP --]]
    dap.adapters.php = {
      type = "executable",
      command = "node",
      args = { daps_path .. "vscode-php-debug/out/phpDebug.js" },
    }

    dap.configurations.php = {
      {
        type = "php",
        request = "launch",
        name = "Listen for Xdebug",
        port = 9003,
      },
      {
        type = "php",
        request = "attach",
        name = "Debug Dockerized php",
        port = 3001,
      },
    }
    --[[ --]]

    vim.fn.sign_define("DapBreakpoint", {
      text = "",
      texthl = "DiagnosticSignError",
      linehl = "",
      numhl = "",
    })

    vim.fn.sign_define("DapBreakpointRejected", {
      text = "", -- or "❌"
      texthl = "DiagnosticSignError",
      linehl = "",
      numhl = "",
    })

    vim.fn.sign_define("DapStopped", {
      text = "", -- or "→"
      texthl = "DiagnosticSignWarn",
      linehl = "Visual",
      numhl = "DiagnosticSignWarn",
    })

    -- Automatically open/close DAP UI
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end

    local opts = { noremap = true, silent = true }

    -- Toggle breakpoint
    vim.keymap.set("n", "<leader>db", function()
      dap.toggle_breakpoint()
    end, opts)

    -- Continue / Start
    vim.keymap.set("n", "<leader>dc", function()
      dap.continue()
    end, opts)

    -- Step Over
    vim.keymap.set("n", "<leader>do", function()
      dap.step_over()
    end, opts)

    -- Step Into
    vim.keymap.set("n", "<leader>di", function()
      dap.step_into()
    end, opts)

    -- Step Out
    vim.keymap.set("n", "<leader>dO", function()
      dap.step_out()
    end, opts)

    -- Keymap to terminate debugging
    vim.keymap.set("n", "<leader>dq", function()
      require("dap").terminate()
    end, opts)

    -- Toggle DAP UI
    vim.keymap.set("n", "<leader>du", function()
      dapui.toggle()
    end, opts)
  end,
}
