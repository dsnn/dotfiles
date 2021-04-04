local builtin = require('el.builtin')
local extensions = require('el.extensions')
local sections = require('el.sections')
local subscribe = require('el.subscribe')

local git_branch = subscribe.buf_autocmd(
	"el_git_branch",
	"BufEnter",
	function(window, buffer)
	  return extensions.git_branch(window, buffer)
	end
)

local generator = function()
return {
	extensions.mode,
		" ",
		git_branch,
		sections.split,
		sections.maximum_width(
			builtin.responsive_file(140, 90),
			0.30
		),
		sections.split,
		builtin.filetype
	}
end

require('el').setup { generator = generator }
