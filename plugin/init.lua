local core = require("clua.core")
local Clua = {}

local function open_float(lines)
	local buffer = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buffer, 0, -1, false, lines)
	local width = math.floor(0.8 * vim.o.columns)
	local height = math.floor(0.8 * vim.o.lines)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)
	local win = vim.api.nvim_open_win(buffer, true, { relative = "editor", width = width, height = height, row = row, col = col, style = "minimal", border = "rounded" })
	vim.keymap.set("n", "q", function()
		vim.api.nvim_win_close(win, true)
	end, { buffer = buffer })
end

function Clua.run(url)
	local result = vim.system({ "curl", "-sL", "-A", "Mozilla/5.0", url }, { text = true }):wait()
	local data = vim.json.decode(result.stdout)
	local parsedData = core.inspect(data)
	open_float(parsedData)
end

function Clua.prompt()
	vim.ui.input({ prompt = "URL: " }, function(url)
		if url and url ~= "" then
			Clua.run(url)
		end
	end)
end

function Clua.setup()
	vim.api.nvim_create_user_command("Clua", function(opts)
		Clua.run(opts.args)
	end, { nargs = 1 })

	vim.keymap.set("n", "<leader>cc", Clua.prompt, { desc = "Clua: inspect URL" })
end

return Clua
