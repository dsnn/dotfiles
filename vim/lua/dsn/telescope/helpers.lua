local M = {}

TelescopeMapArgs = TelescopeMapArgs or {}

function M.set_tele_keymap(key, f, options, buffer)
  local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

  TelescopeMapArgs[map_key] = options or {}

  local mode = "n"
  local rhs = string.format(
    "<cmd>lua R('dsn.telescope.pickers')['%s'](TelescopeMapArgs['%s'])<CR>",
    f,
    map_key
  )

  local map_options = { noremap = true, silent = true, }

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, map_options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
  end
end

return M 
