local reloader = function()
  R "plenary"
  R "telescope"
  R "dsn.telescope"
end

local action_layout = require("telescope.actions.layout")
local actions       = require('telescope.actions')
local previewers    = require('telescope.previewers')
local sorters       = require('telescope.sorters')
local themes        = require('telescope.themes')

require('telescope').setup {
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
        ["<ESC>"] = actions.close, -- do not enter normal mode on esc
        ["<C-s>"] = actions.select_horizontal,
        ["<M-p>"] = action_layout.toggle_preview
      },
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<M-p>"] = action_layout.toggle_preview
      }
    },
    pickers = {
      file_browser = {
        mappings = {
          n = {
            ["l"] = function(prompt_bufnr)
              local selection = require("telescope.actions.state").get_selected_entry()
              local dir = vim.fn.fnamemodify(selection.path, ":p:h")
              require("telescope.actions").close(prompt_bufnr)
              -- Depending on what you want put `cd`, `lcd`, `tcd`
              vim.cmd(string.format("silent lcd %s", dir))
            end
          }
        }
      },
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = true,
        override_file_sorter = true,
      },
      file_browser = {
        theme = "ivy",
        hidden = true,
      }
    }
  }
}

-- load extensions
require('telescope').load_extension('fzy_native')
require('telescope').load_extension('file_browser')

local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

local M = {}

function M.dotfiles()
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

function M.help_tags()
  require('telescope.builtin').help_tags()
end

function M.find_files()
  require('telescope.builtin').find_files {
    layout_strategy = "vertical",
    layout_config = { width = 0.6, height = 0.9 },
    find_command = { 'rg', '--hidden', '--no-ignore', '--files' },
  }
end

function M.grep_prompt()
  require('telescope.builtin').grep_string {
    short_path = false,
    layout_strategy = "vertical",
    layout_config = { width = 0.6, height = 0.9 },
    search = vim.fn.input("Grep String > ")
  }
end

function M.grep_word()
  require('telescope.builtin').grep_string {
    short_path = false,
    word_match = '-w',
    layout_strategy = "vertical",
    layout_config = { width = 0.6, height = 0.9 },
    sorter = sorters.get_fzy_sorter(),
  }
end

function M.git_branches()
  local opts = themes.get_dropdown({
    previewer = false,
    prompt_title = false,
    borderchars = borderchars
  })
  require('telescope.builtin').git_branches(opts)
end

function M.buffers()
  local opts = themes.get_dropdown({
    previewer = false,
    prompt_title = "Buffers",
    layout_config = { width = 0.4, height = 0.4 },
    hidden = true,
    borderchars = borderchars
  })
  require('telescope.builtin').buffers(opts)
end

function M.old_files()
  require('telescope.builtin').old_files()
end

function M.keymaps()
  require('telescope.builtin').keymaps()
end

function M.diagnostics()
  require('telescope.builtin').diagnostics()
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
  require('telescope').extensions.file_browser.file_browser({
    path = "%:p:h",
    files = false,
    hidden = true,
  })
end

function M.live_grep()
  require('telescope.builtin').live_grep()
end

function M.git_status()
  local opts = themes.get_dropdown({
    winblend = 10,
    border = true,
    previewer = false,
    short_path = false,
    borderchars = borderchars
  })
  require('telescope.builtin').git_status(opts)
end

function M.curbuf()
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

TelescopeMapArgs = TelescopeMapArgs or {}

function M.map(key, f, options, buffer)
  local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

  TelescopeMapArgs[map_key] = options or {}

  local mode = "n"
  local rhs = string.format("<cmd>lua R('dsn.telescope')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)

  local map_options = {
    noremap = true,
    silent = true,
  }

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, map_options)
  else
    print(P(rhs))
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
  end
end

return setmetatable({}, {
  __index = function(_, k)
    reloader()

    if M[k] then
      return M[k]
    else
      return require('telescope.builtin')[k]
    end

  end
})
