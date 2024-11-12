function SetColorScheme(color)
	color = color or "nord"

	if color == "nord" then
		vim.g.nord_italic = false
		vim.g.nord_bold = false
	end

	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
	{
		'shaunsingh/nord.nvim',
		config = function() SetColorScheme() end
	}
}

