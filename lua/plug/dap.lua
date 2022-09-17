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

dapui.setup {
  sidebar = {
    elements = {
      {
        id = "scopes",
        size = 0.25, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.25 },
    },
    size = 40,
    position = "right", -- Can be "left", "right", "top", "bottom"
  },
  tray = {
    elements = {},
  },
}

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
