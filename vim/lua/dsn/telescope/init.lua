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
        file_ignore_patterns = {},
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
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<ESC>"] = actions.close,
                ["<CR>"]  = actions.select_default + actions.center
            },
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous
            }
        },
        extension = {
			fzf_writer = {
				use_highlighter = false,
				minimum_grep_characters = 6,
			},
        }
    }
}
