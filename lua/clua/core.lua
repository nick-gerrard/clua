local M = {}

local function walk(tbl, keypath, results)
	local key
	for k, v in pairs(tbl) do
		if keypath == "" then
			key = tostring(k)
		else
			key = keypath .. "." .. tostring(k)
		end
		if type(v) == "table" then
			walk(v, key, results)
		else
			table.insert(results, key .. " (" .. type(v) .. ")")
		end
	end
end

function M.inspect(data)
	local results = {}
	walk(data, "", results)
	return results
end

return M
