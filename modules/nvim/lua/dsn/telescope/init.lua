local reloader = function()
  R "plenary"
  R "telescope"
  R "dsn.telescope"
end

local actions     = require('telescope.actions')
local sorters     = require('telescope.sorters')
local previewers  = require('telescope.previewers')
local themes      = require('telescope.themes')

require('telescope').setup {
    defaults = {
        -- border = {},
        color_devicons = true,
        prompt_prefix = " ",
        -- entry_prefix = "  ",
        file_ignore_patterns = { ".git", "node_modules", "obj", "wwwroot" },
        -- initial_mode = "insert",
        -- layout_defaults = {horizontal = {mirror = false}, vertical = {mirror = false}},
        layout_strategy = "horizontal",
        layout_config = {
          width = 0.95,
          height = 0.85,
          -- preview_cutoff = 120,
          prompt_position = "bottom",

          horizontal = {
            -- width_padding = 0.1,
            -- height_padding = 0.1,
            preview_width = function(_, cols, _)
              if cols > 200 then
                return math.floor(cols * 0.4)
              else
                return math.floor(cols * 0.6)
              end
            end,
          },

          vertical = {
            -- width_padding = 0.05,
            -- height_padding = 1,
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
        -- preview_cutoff = 120,
        -- prompt_position = "top",
        -- results_height = 1,
        -- results_width = 0.8,
        -- selection_caret = " ",
        selection_strategy = "reset",
        -- set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
        -- path_display = true,
        sorting_strategy = "descending",
        -- use_less = true,
        -- width = 0.75,
        --
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
		            ["<C-q>"] = actions.send_to_qflist,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                -- ["<CR>"]  = actions.select_default + actions.center,
                ["<ESC>"] = actions.close,
                ["<C-s>"] = actions.select_horizontal,
                ["<C-space>"] = function(prompt_bufnr)
                  local opts = {
                    callback = actions.toggle_selection,
                    loop_callback = actions.send_selected_to_qflist,
                  }
                  require("telescope").extensions.hop._hop_loop(prompt_bufnr, opts)
                end,
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
            },
            hop = {
              -- keys define your hop keys in order; defaults to roughly lower- and uppercased home row
              -- shown keys here are only subset of defaults!
              keys = { "a", "s", "d", "f", "g", "h", "j", "k", "l", ";"}, -- ... and more

          -- Highlight groups to link to signs and lines; the below configuration refers to demo
              -- sign_hl typically only defines foreground to possibly be combined with line_hl
              sign_hl = { "WarningMsg", "Title" },
              -- optional, typically a table of two highlight groups that are alternated between
              line_hl = { "CursorLine", "Normal" },
          -- options specific to `hop_loop`
              -- true temporarily disables Telescope selection highlighting
              clear_selection_hl = false,
              -- highlight hopped to entry with telescope selection highlight
              -- note: mutually exclusive with `clear_selection_hl`
              trace_entry = true,
              -- jump to entry where hoop loop was started from
              reset_selection = true,
            },
            file_browser = {
              theme = "ivy",
              -- sorting_strategy = "ascending",
              -- prompt_position = "top",
              hidden = true,
              -- mappings = {
              --   ["i"] = {
              --     ["<C-h>"] = fb_actions.goto_home_dir,
              --     ["<C-v>"] = fb_actions_nvim
              --   },
              -- }
            }
        }
    }
}

-- load extensions
require('telescope').load_extension('fzy_native')
require("telescope").load_extension('file_browser')

local M = {}

function M.dotfiles()
  local opts = themes.get_dropdown({
    prompt_title = "~ dotfiles ~",
    short_path = false,
    cwd = "~/dotfiles",
    hidden = true,
    layout_config = { width = 0.6, height = 0.5, preview_width = 0.5 },
    layout_strategy = 'horizontal',
  })
  require('telescope.builtin').find_files(opts)
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
    path_display = true,
    search = vim.fn.input("Grep String > "),
  }
end

function M.grep_word()
  require('telescope.builtin').grep_string {
    short_path = false,
    word_match = '-w',
    -- only_sort_text = true,
    -- layout_strategy = 'vertical',
    sorter = sorters.get_fzy_sorter(),
  }
end

function M.git_branches()
  local opts = themes.get_dropdown({
    previewer = false,
    prompt_title = false,
  })
  require('telescope.builtin').git_branches(opts)
end

function M.buffers()
  local opts = themes.get_dropdown({
    previewer = false,
    prompt_title = "Buffers",
    layout_config = {
      width = 0.4,
      height = 0.4
    },
    hidden = true
  })
  require('telescope.builtin').buffers(opts)
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
  require('telescope').extensions.file_browser.file_browser()
end

function M.git_status()
  local opts = themes.get_dropdown({
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  })
  require('telescope.builtin').git_status(opts)
end

function M.curbuf()
  local opts = themes.get_dropdown({
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
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
