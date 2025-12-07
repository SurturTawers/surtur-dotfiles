local ollama_models = {
	["qwen3"] = {
		-- Qwen3: General coding and math
		["8b"] = "qwen3:8b", -- Too large for my pc, takes forever to generate a response
		["4b"] = "qwen3:4b", -- Reasonable time, it uses some resources
		["1.7b"] = "qwen3:1.7b", -- Really fast, maybe not so accurate, test
		["0.6b"] = "qwen3:0.6b", -- Fastest one, not so accurate, maybe
	},
	-- Qwen2.5-coder: Code specific LLM
	["qwen2.5-coder"] = {
		["3b"] = "qwen2.5-coder:3b",
		["1.5b"] = "qwen2.5-coder:1.5b",
		["0.5b"] = "qwen2.5-coder:0.5b",
	},
}

local openai_models = {
	["gpt-o4"] = {
		mini = "gpt-o4-mini",
	},
	["gpt-o3"] = {
		mini = "gpt-o3-mini",
	},
}

local gemini_models = {
	["gemini-2.5"] = {
		pro = "gemini-2.5-pro",
		flash = "gemini-2.5-flash",
		["flash-lite"] = "gemini-2.5-flash-lite",
	},
}

--[[ 
local configs = {
	copilot = {
		behaviour = {
			-- THIS FIXES THE ERROR OF NOT FINDING THE FILE USING THE CWD AS ROOT
			use_cwd_as_project_root = true,
		},
		provider = "copilot",
	},
	chatgpt = {
		behaviour = {
			-- THIS FIXES THE ERROR OF NOT FINDING THE FILE USING THE CWD AS ROOT
			use_cwd_as_project_root = true,
		},
		provider = "openai",
		openai = {
			endpoint = "https://api.openai.com/v1",
			model = openai_models["gpt-o4"].mini,
			timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
			temperature = 0,
			max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
			--reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
		},
	},

	ollama = {
		behaviour = {
			-- THIS FIXES THE ERROR OF NOT FINDING THE FILE USING THE CWD AS ROOT
			use_cwd_as_project_root = true,
			enable_cursor_planning_mode = true,
		},
		provider = "ollama",
		ollama = {
			model = ollama_models["qwen2.5-coder"]["1.5b"],
		},
	},
	google = {
		provider = "gemini", -- Recommend using Claude
		behaviour = {
			use_cwd_as_project_root = true,
			auto_suggestions = false, -- Experimental stage
			auto_set_highlight_group = true,
			auto_set_keymaps = true,
			auto_apply_diff_after_generation = false,
			support_paste_from_clipboard = false,
		},
		gemini = {
			-- @see https://ai.google.dev/gemini-api/docs/models/gemini
			model = gemini_models["gemini-2.5"].flash,
			temperature = 0,
			max_tokens = 4096,
		},
	},
}
--]]

local providers = {
	gemini = {
		model = gemini_models["gemini-2.5"].flash,
		extra_request_body = {
			generationConfig = {
				temperature = 0.75,
			},
		},
	},
	copilot = {
		model = "gpt-4o-2024-11-20",
	},
	openai = {
		model = openai_models["gpt-o4"].mini,
		extra_request_body = {
			temperature = 0.75,
			max_completion_tokens = 16384, -- Increase this to include reasoning tokens (for reasoning models). For Response API, will be converted to max_output_tokens
			reasoning_effort = "medium", -- low|medium|high, only used for reasoning models. For Response API, this will be converted to reasoning.effort
		},
	},
	ollama = {
		model = ollama_models["qwen2.5-coder"]["1.5b"],
		extra_request_body = {
			options = {
				temperature = 0.15,
				num_ctx = 20480,
				keep_alive = "5m",
			},
		},
	},
}

local avante_config = {
	behaviour = {
		use_cwd_as_project_root = true,
		auto_suggestions = false, -- Experimental stage
		auto_set_highlight_group = true,
		auto_set_keymaps = true,
		auto_apply_diff_after_generation = false,
		support_paste_from_clipboard = false,
	},
	providers = providers,
}

return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	opts = avante_config,
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make",
	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"echasnovski/mini.pick", -- for file_selector provider mini.pick
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		"ibhagwan/fzf-lua", -- for file_selector provider fzf
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
