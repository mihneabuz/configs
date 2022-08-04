local colorizer_ok, colorizer = pcall(require, "colorizer")
if colorizer_ok then
	colorizer.setup()
end

local todo_ok, todo = pcall(require, "todo-comments")
if todo_ok then
	todo.setup({
		keywords = {
			FIX  = { icon = " ", color = "#ff5135", alt = { "BUG", "ISSUE" }},
			TODO = { icon = " ", color = "#ffcc66", alt = { "DO" }},
			WARN = { icon = " ", color = "#ff8800", alt = { "WARNING" }},
			PERF = { icon = " ", color = "#c678dd", alt = { "PERFORMANCE", "OPTIMIZE" }},
			NOTE = { icon = " ", color = "#bbfdbb", alt = { "INFO" }},
			DEL  = { icon = " ", color = "#aabbdd", alt = { "DELETE", "TRASH", "TEMP" }}
		}
	})
end

local project_ok, project = pcall(require, "project_nvim")
if project_ok then
	project.setup({
		detection_method = { "lsp" }
	})
end

local rangehl_ok, rangehl = pcall(require, "range-highlight")
if rangehl_ok then
	rangehl.setup()
end

local scroll_ok, scroll = pcall(require, "neoscroll")
if scroll_ok then
	scroll.setup()
end

local fold_ok, fold_cycle = pcall(require, "fold-cycle")
if fold_ok then
	fold_cycle.setup()
end
