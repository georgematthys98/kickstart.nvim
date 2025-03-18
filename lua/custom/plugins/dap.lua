return {
  lazy = true, -- Enable lazy loading
  keys = { '<F5>', '<F10>', '<F11>', '<F12>' }, -- Load on these key mappings
  cmd = { 'DapContinue', 'DapStepOver', 'DapStepInto', 'DapToggleBreakpoint' }, -- Load on these commands
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Python
    'mfussenegger/nvim-dap-python',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    require('dap-python').setup 'python3'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
        'js-debug-adapter',
        'node-debug2-adapter',
      },
    }

    --- Gets a path to a package in the Mason registry.
    --- Prefer this to `get_package`, since the package might not always be
    --- available yet and trigger errors.
    ---@param pkg string
    ---@param path? string
    local function get_pkg_path(pkg, path)
      pcall(require, 'mason')
      local root = vim.env.MASON or (vim.fn.stdpath('data') .. '/mason')
      path = path or ''
      local ret = root .. '/packages/' .. pkg .. '/' .. path
      return ret
    end

    require('dap').adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'node',
        args = {
          get_pkg_path('js-debug-adapter', '/js-debug/src/dapDebugServer.js'),
          '${port}',
        },
      },
    }

    require('dap').set_log_level 'DEBUG'

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F4>', dap.terminate, { desc = 'Debug: Stop' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })
    vim.keymap.set('n', '<leader>da', function()
      if vim.fn.filereadable '.vscode/launch.json' then
        local dap_vscode = require 'dap.ext.vscode'
        dap_vscode.load_launchjs(nil, {
          ['pwa-node'] = { 'typescript' },
        })
      end
      require('dap').continue()
    end, { desc = 'Debug: Attach' })

    -- Keybinding to load launch.json from a given fp
    vim.keymap.set('n', '<leader>dl', function()
      local dap_vscode = require 'dap.ext.vscode'
      local input = vim.fn.input 'Path to launch.json: '
      dap_vscode.load_launchjs(input, { ['python'] = { 'python' } })
      require('dap').continue()
    end, { desc = 'Debug: Load launch.json' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    ---@diagnostic disable-next-line: missing-fields
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        enabled = true,
        element = 'repl',
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
      layouts = {
        {
          elements = {
            {
              id = 'scopes',
              size = 0.25,
            },
            {
              id = 'breakpoints',
              size = 0.25,
            },
            {
              id = 'stacks',
              size = 0.50,
            },
          },
          position = 'left',
          size = 40,
        },
        {
          elements = { {
            id = 'repl',
            size = 0.5,
          }, {
            id = 'console',
            size = 0.5,
          } },
          position = 'bottom',
          size = 20,
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open

    for _, language in ipairs { 'typescript', 'javascript' } do
      dap.configurations[language] = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Netsched',
          cwd = '/Users/matthysgeorge/LocalDocuments/E2E-FSP-Inload-PocBackend/opti/netsched/optimiser',
          args = function()
            local input = vim.fn.input 'Arguments: '
            return vim.split(input, ' ')
          end,
          program = '/Users/matthysgeorge/LocalDocuments/E2E-FSP-Inload-PocBackend/opti/netsched/optimiser/dist/cli.js',
          sourceMaps = true,
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'FPP propagator',
          cwd = '/Users/matthysgeorge/LocalDocuments/E2E_FPP_Optimiser/propagator/',
          program = '/Users/matthysgeorge/LocalDocuments/E2E_FPP_Optimiser/propagator/dist/cli.js',
          sourceMaps = true,
        },
      }
    end
  end,
}
