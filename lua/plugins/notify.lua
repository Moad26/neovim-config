return {
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup({
			stages = "fade_in_slide_out", -- or "fade", "slide", etc.
			timeout = 3000, -- how long the notification stays
			background_colour = "#000000", -- background color for notifications
			minimum_width = 50, -- minimum width of the notification
		})
	end,
}
