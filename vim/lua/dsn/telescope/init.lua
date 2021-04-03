if not pcall(require, 'telescope') then
  return
end

local actions = require('telescope.actions')
local sorters = require('telescope.sorters')
local previewers = require('telescope.previewers')

require('telescope').load_extension('fzy_native')
require('telescope').load_extension('media_files')

require('telescope').setup {
    defaults = {
        -- border = {},
        -- borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        color_devicons = true,
        prompt_prefix = " ",
        -- entry_prefix = "  ",
        file_ignore_patterns = { ".git", "node_modules" },
        -- initial_mode = "insert",
        -- layout_defaults = {horizontal = {mirror = false}, vertical = {mirror = false}},
        -- layout_strategy = "horizontal",
        -- preview_cutoff = 120,
        -- prompt_position = "top",
        -- results_height = 1,
        -- results_width = 0.8,
        -- selection_caret = " ",
        -- selection_strategy = "reset",
        -- set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
        -- shorten_path = true,
        -- sorting_strategy = "descending",
        -- use_less = true,
        -- width = 0.75,
        -- winblend = 0,
        file_sorter = sorters.get_fzy_sorter,
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
        },
        extensions = {
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true,
            }
        }
    }
}

local M = {}

function M.dotfiles()
  require('telescope.builtin').find_files {
    cwd = "~/dotfiles",
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

function M.find_files()
  require('telescope.builtin').find_files {
    find_command = { 'rg', '--hidden', '--no-ignore', '--files' },
  }
end

function M.grep_prompt()
  require('telescope.builtin').grep_string {
    shorten_path = true,
    search = vim.fn.input("Grep String > "),
  }
end

function M.grep_word()
  require('telescope.builtin').grep_string {
    short_path = true,
    word_match = '-w',
    only_sort_text = true,
    layout_strategy = 'vertical',
    sorter = sorters.get_fzy_sorter(),
  }
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

function M.file_browser()
  require('telescope.builtin').file_browser {
    cwd = "~/",
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    prompt_position = "top",
    hidden = true,
  }
end

return M
