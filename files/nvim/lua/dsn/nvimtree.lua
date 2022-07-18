local tree_cb = require'nvim-tree.config'.nvim_tree_callback

local key_mappings_list = {
  { key = "-",              cb = tree_cb("dir_up") },
  { key = "<2-LeftMouse>",  cb = tree_cb("edit") },
  { key = "<2-RightMouse>", cb = tree_cb("cd") },
  { key = "<BS>",           cb = tree_cb("close_node") },
  { key = "=",              cb = tree_cb("cd") },
  { key = "<C-r>",          cb = tree_cb("full_rename") },
  { key = "<C-t>",          cb = tree_cb("tabnew") },
  { key = "<CR>",           cb = tree_cb("edit") },
  { key = "<S-CR>",         cb = tree_cb("close_node") },
  { key = "<Tab>",          cb = tree_cb("preview") },
  { key = "H",              cb = tree_cb("toggle_dotfiles") },
  { key = "I",              cb = tree_cb("toggle_ignored") },
  { key = "R",              cb = tree_cb("refresh") },
  { key = "<C-k>",          cb = tree_cb("prev_git_item") },
  { key = "<C-j>",          cb = tree_cb("next_git_item") },
  { key = "a",              cb = tree_cb("create") },
  { key = "c",              cb = tree_cb("copy") },
  { key = "d",              cb = tree_cb("remove") },
  { key = "h",              cb = tree_cb("close_node") },
  { key = "l",              cb = tree_cb("edit") },
  { key = "o",              cb = tree_cb("edit") },
  { key = "p",              cb = tree_cb("paste") },
  { key = "q",              cb = tree_cb("close") },
  { key = "r",              cb = tree_cb("rename") },
  { key = "s",              cb = tree_cb("split") },
  { key = "v",              cb = tree_cb("vsplit") },
  { key = "x",              cb = tree_cb("cut") },
}


-- vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_git_ignore     = 1

require('nvim-tree').setup {
  -- auto_close = true,
  ignore_ft_on_setup = { 'startify'},
  disable_netrw = false,
  update_cwd = true,
  renderer = {
    highlight_git = true,
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
      glyphs = {
        default = '',
        symlink = '',
        git = {
            unstaged = "",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "✗"
        },
        folder = {
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = ""
        }
      },
      show = {
        folder = true,
        folder_arrow = true,
        file = true,
        git = true
      }
    },
  },
  update_focused_file = {
    enable = true
  },
  filters = {
    dotfiles = false,
    custom = {'node_modules', '.cache', 'obj' }
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 50,
    number = true,
    relativenumber = true,
    mappings = {
      list = key_mappings_list
    }
  },
}
