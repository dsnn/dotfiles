if not pcall(require, 'telescope') then
  return
end

local actions = require('telescope.actions')
local sorters = require('telescope.sorters')
local previewers = require('telescope.previewers')

require('telescope').load_extension('media_files')

require('telescope').setup {
    defaults = {
        border = {},
        borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        color_devicons = true,
        entry_prefix = "  ",
        file_ignore_patterns = { ".git", "node_modules" },
        initial_mode = "insert",
        layout_defaults = {horizontal = {mirror = false}, vertical = {mirror = false}},
        layout_strategy = "horizontal",
        preview_cutoff = 120,
        prompt_position = "top",
        prompt_prefix = " ",
        results_height = 1,
        results_width = 0.8,
        selection_caret = " ",
        selection_strategy = "reset",
        set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
        shorten_path = true,
        sorting_strategy = "descending",
        use_less = true,
        width = 0.75,
        winblend = 0,
        file_sorter = sorters.get_fuzzy_file,
        generic_sorter = sorters.get_generic_fuzzy_sorter,
        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,
        buffer_previewer_maker = previewers.buffer_previewer_maker,
        mappings = {
            i = {
		["<C-q>"] = actions.send_to_qflist,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                -- ["<CR>"]  = actions.select_default + actions.center,
                ["<ESC>"] = actions.close
            },
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous
            }
        }
    }
}

local M = {}

function M.dotfiles()
  require('telescope.builtin').find_files {
    cwd = "~/dotfiles/",
    hidden = true,
    prompt_title = "~ dotfiles ~",
    shorten_path = false,

    layout_strategy = 'horizontal',
    layout_config = {
      preview_width = 0.65,
    },
  }
end


function M.help_tags()
  require('telescope.builtin').help_tags {
    show_version = true,
  }
end

function M.search_all_files()
  require('telescope.builtin').find_files()
end

function M.git_branches()
  require('telescope.builtin').git_branches()
end

function M.buffers()
  require('telescope.builtin').buffers {
    shorten_path = false,
  }
end

function M.colorscheme()
  require('telescope.builtin').colorscheme()
end

function M.registers()
  require('telescope.builtin').registers()
end

function M.quickfix()
  require('telescope.builtin').quickfix()
end

return M
