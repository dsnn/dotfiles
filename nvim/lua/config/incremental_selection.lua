local M = {}
local selections = {}

local function same_range(first, second)
  local fsr, fsc, fer, fec = first:range()
  local ssr, ssc, ser, sec = second:range()
  return fsr == ssr and fsc == ssc and fer == ser and fec == sec
end

local function contains(outer, inner)
  local osr, osc, oer, oec = outer:range()
  local isr, isc, ier, iec = inner:range()
  local starts_before = osr < isr or (osr == isr and osc <= isc)
  local ends_after = oer > ier or (oer == ier and oec >= iec)
  return starts_before and ends_after
end

local function select_node(bufnr, node)
  local start_row, start_col, end_row, end_col = node:range()

  if end_col == 0 and end_row > start_row then
    end_row = end_row - 1
    end_col = #vim.api.nvim_buf_get_lines(bufnr, end_row, end_row + 1, false)[1]
  end

  if vim.api.nvim_get_mode().mode ~= "v" then
    vim.cmd.normal({ "v", bang = true })
  end

  vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })
  vim.cmd.normal({ "o", bang = true })
  vim.api.nvim_win_set_cursor(0, { end_row + 1, math.max(end_col - 1, 0) })
end

local function start_selection(bufnr)
  local parser = vim.treesitter.get_parser(bufnr)
  parser:parse()

  local node = vim.treesitter.get_node({ bufnr = bufnr, ignore_injections = false })
  if not node then
    return
  end

  selections[bufnr] = { node }
  select_node(bufnr, node)
end

local function surrounding_scope(bufnr, node)
  local parser = vim.treesitter.get_parser(bufnr)
  local tree = parser:parse()[1]
  local query = vim.treesitter.query.get(parser:lang(), "locals")
  if not tree or not query then
    return node:parent()
  end

  local scope
  for id, candidate in query:iter_captures(tree:root(), bufnr) do
    if query.captures[id] == "local.scope" and not same_range(candidate, node) and contains(candidate, node) then
      if not scope or contains(scope, candidate) then
        scope = candidate
      end
    end
  end

  return scope or node:parent()
end

local function grow_selection(bufnr, get_parent)
  local stack = selections[bufnr]
  if not stack or #stack == 0 then
    start_selection(bufnr)
    return
  end

  local node = stack[#stack]
  local parent = get_parent(node)
  while parent and same_range(parent, node) do
    parent = parent:parent()
  end
  if not parent then
    return
  end

  table.insert(stack, parent)
  select_node(bufnr, parent)
end

local function shrink_selection(bufnr)
  local stack = selections[bufnr]
  if not stack or #stack < 2 then
    return
  end

  table.remove(stack)
  select_node(bufnr, stack[#stack])
end

function M.attach(bufnr)
  vim.keymap.set("n", "gnn", function()
    start_selection(bufnr)
  end, { buffer = bufnr, silent = true, desc = "Start Treesitter selection" })

  vim.keymap.set("x", "grn", function()
    grow_selection(bufnr, function(node)
      return node:parent()
    end)
  end, { buffer = bufnr, silent = true, desc = "Grow Treesitter selection" })

  vim.keymap.set("x", "grc", function()
    grow_selection(bufnr, function(node)
      return surrounding_scope(bufnr, node)
    end)
  end, { buffer = bufnr, silent = true, desc = "Grow selection to scope" })

  vim.keymap.set("x", "grm", function()
    shrink_selection(bufnr)
  end, { buffer = bufnr, silent = true, desc = "Shrink Treesitter selection" })
end

local group = vim.api.nvim_create_augroup("TreesitterSelectionState", { clear = true })
vim.api.nvim_create_autocmd("BufWipeout", {
  group = group,
  callback = function(args)
    selections[args.buf] = nil
  end,
})

return M
