local dap = require("dap")

dap.adapters.php = {
	type = "executable",
	command = "nodejs",
	args = {
		require("mason-registry").get_package("php-debug-adapter"):get_install_path() .. "/extension/out/phpDebug.js",
	},
}

dap.configurations.php = {
	{
		name = "Launch current script",
		type = "php",
		request = "launch",
		program = "${file}",
		port = "9003",
		cwd = "${workspaceFolder}",
		console = "integratedTerminal",
	},
}
