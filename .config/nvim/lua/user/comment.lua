local success, comment = pcall(require, "Comment")
if not success then
	return
end

local success_context, context_utils = pcall(require, "ts_context_commentstring.utils")
local success_internal, context_internal = pcall(require, 'ts_context_commentstring.internal')

comment.setup({
	pre_hook = function (ctx)
		if not success_context or not success_internal then
			return
		end

		local U = require 'Comment.utils'

    local location = nil
    if ctx.ctype == U.ctype.block then
      location = context_utils.get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = context_utils.get_visual_start_location()
    end

    return context_internal.calculate_commentstring {
      key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
      location = location,
    }
	end
})
