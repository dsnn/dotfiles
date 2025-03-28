-- https://github.com/nvim-telescope/telescope.nvim

local telescope = require("telescope")
local builtin = require("telescope.builtin")

local function dotfiles()
  local themes = require("telescope.themes")
  local opts = themes.get_dropdown({
    prompt_title = "~ dotfiles ~",
    short_path = false,
    cwd = "~/dotfiles",
    hidden = true,
    layout_strategy = "vertical",
    layout_config = { width = 0.6, height = 0.9 },
  })
  builtin.find_files(opts)
end

local function find_files()
  builtin.find_files({
    layout_strategy = "vertical",
    layout_config = { width = 0.6, height = 0.9 },
    find_command = { "rg", "--hidden", "--no-ignore", "--files" },
  })
end

local function grep_word()
  local sorters = require("telescope.sorters")
  builtin.grep_string({
    short_path = false,
    word_match = "-w",
    layout_strategy = "vertical",
    layout_config = { width = 0.6, height = 0.9 },
    sorter = sorters.get_fzy_sorter(),
  })
end

local function buffers()
  local themes = require("telescope.themes")
  -- local opts = themes.get_dropdown({
  local opts = themes.get_ivy({
    prompt_title = "~ buffers ~",
    hidden = true,
    -- layout_strategy = "vertical",
    -- layout_config = { width = 0.6, height = 0.9 },
    layout_config = { height = 0.5 },
    initial_mode = "normal",
  })
  builtin.buffers(opts)
end

local function grep_current_cword()
  local word = vim.fn.expand("<cword>")
  builtin.grep_string({ search = word })
end

local function grep_current_cWORD()
  local word = vim.fn.expand("<cWORD>")
  builtin.grep_string({ search = word })
end

local function oldfiles()
  local themes = require("telescope.themes")
  local opts = themes.get_dropdown({
    short_path = false,
    hidden = true,
    layout_strategy = "vertical",
    layout_config = { width = 0.6, height = 0.9 },
  })
  builtin.oldfiles(opts)
end

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<Leader><space>", buffers, opts)
vim.keymap.set("n", "<space>gb", builtin.git_branches, opts)
vim.keymap.set("n", "<space>gc", builtin.git_bcommits, opts)
vim.keymap.set("n", "<space>gf", builtin.git_files, opts)
vim.keymap.set("n", "<space>gs", builtin.git_status, opts)
vim.keymap.set("n", "<space>sW", grep_current_cWORD, opts)
vim.keymap.set("n", "<Leader>f", find_files, opts)
vim.keymap.set("n", "<space>sa", find_files, opts)
vim.keymap.set("n", "<space>sc", builtin.colorscheme, opts)
vim.keymap.set("n", "<space>sd", dotfiles, opts)
vim.keymap.set("n", "<space>sf", grep_word, opts)
vim.keymap.set("n", "<space>sg", builtin.live_grep, opts)
vim.keymap.set("n", "<Leader>g", builtin.live_grep, opts)
vim.keymap.set("n", "<space>sh", builtin.help_tags, opts)
vim.keymap.set("n", "<space>sk", builtin.keymaps, opts)
vim.keymap.set("n", "<space>sl", builtin.resume, opts)
vim.keymap.set("n", "<space>sq", builtin.quickfix, opts)
vim.keymap.set("n", "<space>sr", oldfiles, opts)
vim.keymap.set("n", "<Leader>r", oldfiles, opts)
vim.keymap.set("n", "<space>sw", grep_current_cword, opts)

local action_layout = require("telescope.actions.layout")
local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")

telescope.setup({
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
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-s>"] = actions.select_vertical,
        ["<C-v>"] = action_layout.toggle_preview,
      },
      n = {
        ["d"] = actions.delete_buffer,
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["p"] = action_layout.toggle_preview,
        ["q"] = actions.close,
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  },
})

require("telescope").load_extension("fzf")
