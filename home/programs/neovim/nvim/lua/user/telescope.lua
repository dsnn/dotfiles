local function notes()
  require('telescope.builtin').find_files({
    cwd = "~/projects/notes",
    file_ignore_patterns = { "assets/*"}
  })
end

local function projects()
  require('telescope.builtin').find_files({
    cwd = "~/projects",
    file_ignore_patterns = { "node_modules/*"},
  })
end

local function dotfiles()
  local themes = require('telescope.themes')
  local opts = themes.get_dropdown({
    prompt_title = "~ dotfiles ~",
    short_path = false,
    cwd = "~/dotfiles",
    hidden = true,
    layout_strategy = "vertical",
    layout_config = { width = 0.6, height = 0.9 },
  })
  require('telescope.builtin').find_files(opts)
end

local function help_tags()
  require('telescope.builtin').help_tags()
end

local function find_files()
  require('telescope.builtin').find_files {
    layout_strategy = "vertical",
    layout_config = { width = 0.6, height = 0.9 },
    find_command = { 'rg', '--hidden', '--no-ignore', '--files' },
  }
end

local function grep_prompt()
  require('telescope.builtin').grep_string {
    short_path = false,
    layout_strategy = "vertical",
    layout_config = { width = 0.6, height = 0.9 },
    search = vim.fn.input("Grep String > ")
  }
end

local function grep_word()
  local sorters = require('telescope.sorters')
  require('telescope.builtin').grep_string {
    short_path = false,
    word_match = '-w',
    layout_strategy = "vertical",
    layout_config = { width = 0.6, height = 0.9 },
    sorter = sorters.get_fzy_sorter(),
  }
end

local function buffers()
  local themes = require('telescope.themes')
  local opts = themes.get_dropdown({
    previewer = false,
    prompt_title = "Buffers",
    layout_config = { width = 0.4, height = 0.4 },
    hidden = true,
  })
  require('telescope.builtin').buffers(opts)
end

local function live_grep()
  require('telescope.builtin').live_grep()
end

local M = {
  "nvim-telescope/telescope.nvim",
  tag = '0.1.5',
  dependencies = {
    "nvim-lua/plenary.nvim",
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  keys = {
    { "<space>fd", dotfiles, desc = "Telescope: Find dotfiles" },
    { "<space>gp", grep_prompt, desc = "Telescope: Grep string" },
    { '<Leader><space>', buffers, desc = "Telescope: Open buffers" },
    { '<space>fa', find_files, desc = "Telescope: Search for files (respecting .gitignore)" },
    { '<space>fc', "<cmd>Telescope colorscheme<CR>", desc = "Telescope: Available colorschemes" },
    { '<space>fh', help_tags, desc = "Telescope: Help tags" },
    { '<space>fm', projects, desc = "Telescope: Projects file browser" },
    { '<space>fn', notes, desc = "Telescope: Notes file browser" },
    { '<space>fr', "<cmd>Telescope oldfiles<CR>", desc = "Telescope: Previously open files" },
    { '<space>gl', live_grep, desc = "Telescope: Live grep" },
    { '<space>gw', grep_word, desc = "Telescope: Grep word under cursor" },
    { '<space>k', "<cmd>Telescope keymaps<CR>", desc = "Telescope: List (and run on <CR>) normal mode keymappings" },
  },
}

function M.config()
  local action_layout = require("telescope.actions.layout")
  local actions       = require('telescope.actions')
  local previewers    = require('telescope.previewers')
  local sorters       = require('telescope.sorters')

  require("telescope").setup({
    defaults = {
      color_devicons = true,
      file_ignore_patterns = { "^.git/", "^node_modules/", "^obj/", "^wwwroot/" },
      layout_strategy = "horizontal",
      layout_config = {
        width = 0.95,
        height = 0.85,
        prompt_position = "bottom",
        horizontal = {
          preview_width = function(_, cols, _)
            if cols > 200 then
              return math.floor(cols * 0.4)
            else
              return math.floor(cols * 0.6)
            end
          end,
        },
        vertical = {
          width = 0.9,
          height = 0.95,
          preview_height = 0.5,
        },
        flex = {
          horizontal = {
            preview_width = 0.9,
          },
        },
      },
      set_env = { ["COLORTERM"] = "truecolor" },
      selection_strategy = "reset",
      sorting_strategy = "descending",
      scroll_strategy = "cycle",
      winblend = 0,
      file_previewer = previewers.vim_buffer_cat.new,
      file_sorter = sorters.get_fzy_sorter,
      generic_sorter = sorters.get_generic_fuzzy_sorter,
      grep_previewer = previewers.vim_buffer_vimgrep.new,
      qflist_previewer = previewers.vim_buffer_qflist.new,
      buffer_previewer_maker = previewers.buffer_previewer_maker,
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,

          ["<C-q>"] = actions.send_to_qflist,
          ["<C-s>"] = actions.select_vertical,
          ["<C-p>"] = action_layout.toggle_preview,
        },
        n = {
          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["p"] = action_layout.toggle_preview,
          ["q"] = actions.close, 
        }
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        }
      }
    }
  })

  require('telescope').load_extension('fzf')

end

return M
