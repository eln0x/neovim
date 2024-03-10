--
-- Dap configuration
--
-- https://github.com/mfussenegger/nvim-dap

local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
    return
end

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

--
-- Dapui configuration
--
-- https://github.com/rcarriga/nvim-dap-ui

local ui_ok, dapui = pcall(require, "dapui")
if not ui_ok then
    return
end

dapui.setup({
    layouts = {
        {
            elements = {
                'scopes',
                'breakpoints',
                'stacks',
                'watches',
            },
            size = 40,
            position = 'left',
        },
        {
            elements = {
                'repl',
                'console',
            },
            size = 10,
            position = 'bottom',
        },
    },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

--
-- Dap Virtual Text configuration
--
-- https://github.com/theHamsta/nvim-dap-virtual-text

local vtext_ok, vtext = pcall(require, "nvim-dap-virtual-text")
if not vtext_ok then
    return
end

vtext.setup()
