if not pcall(require, 'telescope') then
  return
end

local actions     = require('telescope.actions')
local sorters     = require('telescope.sorters')
local previewers  = require('telescope.previewers')

-- require('telescope').load_extension('cheat')
require('telescope').load_extension('fzy_native')

require('telescope').setup {
    defaults = {
        -- border = {},
        -- borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        color_devicons = true,
        prompt_prefix = " ",
        -- entry_prefix = "  ",
        file_ignore_patterns = { ".git", "node_modules", "obj" },
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
                override_generic_sorter = true,
                override_file_sorter = true,
            }
        }
    }
}

local dropdown = function(opts)
  return require('telescope.themes').get_dropdown(opts)
end

local center_list = {
  borderchars = {
    { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
    prompt = {"─", "│", " ", "│", '┌', '┐', "│", "│"},
    results = {"─", "│", "─", "│", "├", "┤", "┘", "└"},
    preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
  },
  width = 0.5,
  previewer = false,
  prompt_title = false,
  results_height = 15,
}

local M = {}

function M.dotfiles()
  local opts = vim.deepcopy(center_list)
  opts.hidden = true
  opts.prompt_title = "~ dotfiles ~"
  opts.shorten_path = false
  require('telescope.builtin').find_files(dropdown(opts)) 
end

function M.help_tags()
  require('telescope.builtin').help_tags()
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
  local theme = dropdown(center_list)
  require('telescope.builtin').git_branches(theme)
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

-- Fix symbolic links: https://github.com/nvim-telescope/telescope.nvim/issues/693
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
