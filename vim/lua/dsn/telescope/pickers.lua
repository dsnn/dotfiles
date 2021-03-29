local themes = require('telescope.themes')
local sorters = require('telescope.sorters')

local M = {}

function M.edit_dotfiles()
  require('telescope.builtin').find_files {
    prompt_title = "~ dotfiles ~",
    shorten_path = false,
    cwd = "~/dotfiles/",

    layout_strategy = 'horizontal',
    layout_config = {
      preview_width = 0.65,
    },
  }
end

function M.git_branches()
  -- actions mappings
  require('telescope.builtin').git_branches()
end

function M.buffers()
  require('telescope.builtin').buffers {
    shorten_path = false,
  }
end

function M.help_tags()
  require('telescope.builtin').help_tags {
    show_version = true,
  }
end

function M.search_all_files()
  require('telescope.builtin').find_files()
--  require('telescope.builtin').find_files {
--    find_command = { 'fd', '--no-ignore', '--hidden', },
--  }
end

-- function M.grep_str()
--   local opts = {
--     short_path = true,
--     word_match = '-w',
--     only_sort_text = true,
--     layout_strategy = 'vertical',
--     sorter = sorters.get_fzy_sorter(),
--   }
--   require('telescope.builtin').grep_string(opts)
-- end

-- function M.grep_last_search()
--   local register = vim.fn.getreg('/'):gsub('\\<', ''):gsub('\\>', ''):gsub("\\C", "")
--   local opts = {
--     layout_strategy = 'vertical',
--     shorten_path = true,
--     word_match = '-w',
--     search = register,
--   }
--   require('telescope.builtin').grep_string(opts)
-- end

-- function M.git_files()
--   local opts = themes.get_dropdown {
--     winblend = 10,
--     border = true,
--     previewer = false,
--     shorten_path = false,
--   }
-- 
--   require('telescope.builtin').git_files(opts)
-- end
-- function M.grep_live()
--  require('telescope').extensions.fzf_writer.staged_grep {
--    shorten_path = true,
--    previewer = false,
--    fzf_separator = "|>",
--  }
-- end



-- function M.curbuf()
--   local opts = themes.get_dropdown {
--     winblend = 10,
--     border = true,
--     previewer = false,
--     shorten_path = false,
--
--     -- layout_strategy = 'current_buffer',
--   }
--   require('telescope.builtin').current_buffer_fuzzy_find(opts)
-- end


-- function M.file_browser()
--   require('telescope.builtin').file_browser {
--     sorting_strategy = "ascending",
--     scroll_strategy = "cycle",
--     prompt_position = "top",
--   }
-- end

return setmetatable({}, {
  __index = function(_, k)
    -- reloader()

    if M[k] then
      return M[k]
    else
      return require('telescope.builtin')[k]
    end
  end,
})
