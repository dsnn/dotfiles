-- if no files are shown in file browser, try:
-- https://github.com/sharkdp/fd#on-ubuntu
-- `sudo dpkg -i fd_<version>.deb`

local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

local function dotfiles()
  local themes = require('telescope.themes')
  local opts = themes.get_dropdown({
    prompt_title = "~ dotfiles ~",
    short_path = false,
    cwd = "~/dotfiles",
    hidden = true,
    layout_strategy = "vertical",
    layout_config = { width = 0.6, height = 0.9 },
    borderchars = borderchars,
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

local function git_branches()
  local themes = require('telescope.themes')
  local opts = themes.get_dropdown({
    previewer = false,
    prompt_title = false,
    borderchars = borderchars
  })
  require('telescope.builtin').git_branches(opts)
end

local function buffers()
  local themes = require('telescope.themes')
  local opts = themes.get_dropdown({
    previewer = false,
    prompt_title = "Buffers",
    layout_config = { width = 0.4, height = 0.4 },
    hidden = true,
    borderchars = borderchars
  })
  require('telescope.builtin').buffers(opts)
end

local function file_browser()
  require('telescope').extensions.file_browser.file_browser({
    path = "%:p:h",
    files = false,
    hidden = false,
    previewer = false,
  })
end

local function live_grep()
  require('telescope.builtin').live_grep()
end

local function git_status()
  local themes = require('telescope.themes')
  local opts = themes.get_dropdown({
    winblend = 10,
    border = true,
    previewer = false,
    short_path = false,
    borderchars = borderchars
  })
  require('telescope.builtin').git_status(opts)
end

local function curbuf()
  local themes = require('telescope.themes')
  local opts = themes.get_dropdown({
    winblend = 10,
    border = true,
    previewer = false,
    short_path = false,
    borderchars = borderchars,
    layout_config = {
      width = 0.8,
      height = 0.8,
    }
  })
  require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

return {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },
  lazy = false,
  branch = '0.1.x',
  keys = {
    { "<space>fd", dotfiles, desc = "Telescope: Find dotfiles" },
    { "<space>gp", grep_prompt, desc = "Telescope: Grep string" },
    { '<Leader><space>', buffers, desc = "Telescope: Open buffers" },
    { '<space>fa', find_files, desc = "Telescope: Search for files (respecting .gitignore)" },
    { '<space>fc', "<cmd>Telescope colorscheme<CR>", desc = "Telescope: Available colorschemes" },
    { '<space>fe', file_browser, desc = "Telescope: File browser" },
    { '<space>ff', curbuf, desc = "Telescope: Live fuzzy search in current buffer" },
    { '<space>fh', help_tags, desc = "Telescope: Help tags" },
    { '<space>fo', "<cmd>Telescope oldfiles<CR>", desc = "Telescope: Previously open files" },
    { '<space>fp', "<cmd>Telescope diagnostics<CR>", desc = "Telescope: List diagnostics" },
    { '<space>fq', "<cmd>Telescope quickfix<CR>", desc = "Telescope: Quickfix list" },
    { '<space>fr', "<cmd>Telescope registers<CR>", desc = "Telescope: Registers" },
    { '<space>gb', git_branches, desc = "Telescope: Git branches for current directory" },
    { '<space>gl', live_grep, desc = "Telescope: Live grep" },
    { '<space>gs', git_status, desc = "Telescope: Git status" },
    { '<space>gw', grep_word, desc = "Telescope: Grep word under cursor" },
    { '<space>k', "<cmd>Telescope keymaps<CR>", desc = "Telescope: List (and run on <CR>) normal mode keymappings" },
  },
  config = function()
    local action_layout = require("telescope.actions.layout")
    local actions       = require('telescope.actions')
    local previewers    = require('telescope.previewers')
    local sorters       = require('telescope.sorters')
    -- local themes        = require('telescope.themes')

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
            -- ["<ESC>"] = actions.close, -- do not enter normal mode on esc
            ["<C-s>"] = actions.select_horizontal,
            ["<M-p>"] = action_layout.toggle_preview,
            ["<C-e>"] = false,
          },
          n = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<M-p>"] = action_layout.toggle_preview
          }
        },
        pickers = {
          --   find_files = {
          --     find_command = { fd, "--type", "f", "--hidden", "--exclude", ".git" },
          --     mappings = {
          --       n = {
          --         ["cd"] = function(prompt_bufnr)
          --           local selection = require("telescope.actions.state").get_selected_entry()
          --           local dir = vim.fn.fnamemodify(selection.path, ":p:h")
          --           require("telescope.actions").close(prompt_bufnr)
          --           -- Depending on what you want put `cd`, `lcd`, `tcd`
          --           cmd(string.format("silent lcd %s", dir))
          --         end,
          --       },
          --     },
          --   },
        },
        extensions = {
          fzy_native = {
            override_generic_sorter = true,
            override_file_sorter = true,
          },
          file_browser = {
            theme = "ivy",
            hidden = true,
            hijack_netrw = true,
          }
        }
      }
    })

    -- load extensions
    require('telescope').load_extension('fzy_native')
    require('telescope').load_extension('file_browser')
  end
}
