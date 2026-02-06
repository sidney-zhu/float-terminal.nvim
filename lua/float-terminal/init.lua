local M = {}

local state = {
	floating = {
		buf = -1,
		win = -1,
	},
}

-- Calculate the center position
local function get_win_config()
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	-- Calculate the position to center the window
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	return {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		border = "rounded",
		title = " Terminal ",
		title_pos = "center",
	}
end

local function create_floating_window(opts)
	opts = opts or {}
	-- Create a buffer
	local buf = nil
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
	end
	vim.b[buf].miniindentscope_disable = true

	-- Define window configuration
	local win_config = get_win_config()

	-- Create the floating window
	local win = vim.api.nvim_open_win(buf, true, win_config)

	-- Make the border color is same as Telescope
	local hl_setting = "Normal:TelescopeResultsNormal,FloatBorder:TelescopeResultsBorder"
	if vim.fn.hlexists("TelescopeResultsBorder") == 0 then
		hl_setting = "Normal:NormalFloat,FloatBorder:FloatBorder"
	end
	vim.api.nvim_set_option_value("winhighlight", hl_setting, { scope = "local", win = win })

	return { buf = buf, win = win }
end

M.toggle_terminal = function()
	-- Check if the win is valid and visible
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = create_floating_window({ buf = state.floating.buf })

		-- If buffer's type is not terminal, start terminal
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end
		-- Enter insert mode after start
		vim.cmd("startinsert")
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end

M.setup = function(opts)
	opts = opts or {}
	vim.keymap.set({ "n", "t" }, "<leader>tt", M.toggle_terminal, { desc = "Toggle Floating Terminal" })
	vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Exit Terminal Mode" })

	-- Listen the size changed in window
	vim.api.nvim_create_autocmd("VimResized", {
		group = vim.api.nvim_create_augroup("FloatTermResizer", { clear = true }),
		callback = function()
			if vim.api.nvim_win_is_valid(state.floating.win) then
				local config = get_win_config()
				vim.api.nvim_win_set_config(state.floating.win, config)
			end
		end,
	})

	vim.api.nvim_create_autocmd("BufEnter", {
		group = vim.api.nvim_create_augroup("FloatTermInsert", { clear = true }),
		pattern = "*",
		callback = function()
			if vim.bo.buftype == "terminal" and vim.api.nvim_get_current_buf() == state.floating.buf then
				vim.cmd("startinsert")
			end
		end,
	})
end

return M
