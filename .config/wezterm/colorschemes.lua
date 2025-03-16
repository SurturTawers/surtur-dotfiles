return {
	nightfox = "nightfox",
	neutron = "Neutron",
	catppuccin = {
		mocha = "Catppuccin Mocha",
	},
	mirage = "Mirage",
	custom = {
		test = {
			foreground = "silver",
			background = "black",
			cursor_bg = "#52ad80",
			cursor_fg = "black",
		},
		gentleman = {
			sakura = {
				foreground = "#786577", -- na: texto
				background = "#1c1a1c", -- bl: fondo
				cursor_bg = "#9e97d0", -- ca: púrpura
				cursor_fg = "#c5a3a9", -- na: texto
				cursor_border = "#9e97d0", -- ca: púrpura
				selection_fg = "#c5a3a9", -- na: texto
				selection_bg = "#3f3b3e", -- gr: gris
				scrollbar_thumb = "#2e2d2f", -- gl: gris claro
				split = "#2e2d2f", -- gl: gris claro
				ansi = {
					"#1c1a1c", -- Black: bl: negro
					"#c58ea7", -- Red: ia: rojo
					"#878fb9", -- Green: va: verde (azul)
					"#9e97d0", -- Yellow: ca: amarillo (púrpura)
					"#665E7A", -- Blue: vb: azul oscuro
					"#9e97d0", -- Magenta: ca: magenta
					"#c58ea7", -- Cyan: ia: cyan (rosa)
					"#c5a3a9", -- White: na: blanco
				},
				brights = {
					"#3f3b3e", -- Bright Black: gr: gris oscuro
					"#c58ea7", -- Bright Red: ia: rojo
					"#878fb9", -- Bright Green: va: verde
					"#9e97d0", -- Bright Yellow: ca: amarillo
					"#665E7A", -- Bright Blue: vb: azul
					"#9e97d0", -- Bright Magenta: ca: magenta
					"#c58ea7", -- Bright Cyan: ia: cyan
					"#c5a3a9", -- Bright White: na: blanco
				},
				indexed = {
					[16] = "#9e97d0", -- ca: púrpura
					[17] = "#c58ea7", -- ia: rosa
				},
			},
			oldworld = {
				-- --- Base colors ---
				foreground = "#C9C7CD", -- na: main text (light gray)
				background = "#000000", -- bl: dark background (almost black)

				-- --- Cursor colors ---
				cursor_bg = "#92A2D5", -- ca: blue lavender (cursor background)
				cursor_fg = "#C9C7CD", -- na: main text (cursor foreground)
				cursor_border = "#92A2D5", -- ca: blue lavender (cursor border)

				-- --- Selection colors ---
				selection_fg = "#C9C7CD", -- na: main text (selection foreground)
				selection_bg = "#3B4252", -- gr: dark gray (selection background)

				-- --- UI colors ---
				scrollbar_thumb = "#4C566A", -- nb: medium gray (scrollbar thumb)
				split = "#4C566A", -- nb: medium gray (split line)

				-- --- ANSI colors ---
				ansi = {
					"#000000", -- Black: bl: dark background (almost black)
					"#EA83A5", -- Red: ia: intense pink (errors)
					"#90B99F", -- Green: va: soft green (success)
					"#E6B99D", -- Yellow: ca: beige (warnings)
					"#85B5BA", -- Blue: va: light blue-green (information)
					"#92A2D5", -- Magenta: ca: blue lavender (highlight)
					"#85B5BA", -- Cyan: va: light blue-green (links)
					"#C9C7CD", -- White: na: main text (light gray)
				},

				-- --- Bright ANSI colors ---
				brights = {
					"#4C566A", -- Bright Black: nb: medium gray (bright black)
					"#EA83A5", -- Bright Red: ia: intense pink (bright red)
					"#90B99F", -- Bright Green: va: soft green (bright green)
					"#E6B99D", -- Bright Yellow: ca: beige (bright yellow)
					"#85B5BA", -- Bright Blue: va: light blue-green (bright blue)
					"#92A2D5", -- Bright Magenta: ca: blue lavender (bright magenta)
					"#85B5BA", -- Bright Cyan: va: light blue-green (bright cyan)
					"#C9C7CD", -- Bright White: na: main text (bright white)
				},

				-- --- Indexed colors ---
				indexed = {
					[16] = "#F5A191", -- ca: light peach (orange)
					[17] = "#E29ECA", -- ia: soft pink (pink)
				},
			},
		},
	},
}
