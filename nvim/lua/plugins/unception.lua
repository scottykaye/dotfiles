vim.api.nvim_create_autocmd("User", {
	pattern = "UnceptionEditRequestReceived",
	callback = function()
		require("FTerm").toggle()
	end,
})
