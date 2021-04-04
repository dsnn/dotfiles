local generator = function(win_id)
    local el_segments = {}

    local extensions = require('el.extensions')
    table.insert(el_segments, extensions.mode)
    table.insert(el_segments, '%f')

    table.insert(el_segments, extensions.git_changes)

    local helper = require("el.helper")
    table.insert(el_segments, helper.async_buf_setter(
      win_id,
      'el_git_stat',
      extensions.git_changes,
      5000
    ))

    return el_segments
end

require('el').setup { generator = generator }
