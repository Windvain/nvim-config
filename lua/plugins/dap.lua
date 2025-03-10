return {
	"mfussenegger/nvim-dap",
	dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" },

	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dap.adapters.codelldb = {
			type = "executable",
			command = "D:\\Binaries\\codelldb\\extension\\adapter\\codelldb.exe",

			detached = false
		}

		dapui.setup()
		dap.listeners.before.attach.dapui_config = function() dapui.open() end
		dap.listeners.before.launch.dapui_config = function() dapui.open() end

		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end

		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
--		dap.configurations.h = dap.configurations.cpp
	end
}
--[[
return {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
}]]--
