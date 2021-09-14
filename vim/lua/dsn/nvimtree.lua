
vim.g.nvim_tree_auto_close = 1 
vim.g.nvim_tree_auto_ignore_ft = { 'startify' }
vim.g.nvim_tree_disable_netrw = 0 
vim.g.nvim_tree_follow = 0 
vim.g.nvim_tree_indent_markers = 1 
vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache', 'obj' }
vim.g.nvim_tree_git_hl = 1 
vim.g.nvim_tree_git_ignore = 1 
vim.g.nvim_tree_hide_dotfiles = 0 
vim.g.nvim_tree_width = 50 
vim.g.nvim_tree_update_cwd = 1 

vim.g.nvim_tree_show_icons = {
  folders = 1,
  folder_arrows = 1,
  files = 1,
  git = 1
}


local tree_cb = require'nvim-tree.config'.nvim_tree_callback

vim.g.nvim_tree_bindings = {
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
    { key = "[c",             cb = tree_cb("prev_git_item") },
    { key = "]c",             cb = tree_cb("next_git_item") },
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

vim.g.nvim_tree_icons = {
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
}
