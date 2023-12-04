return {
  "andymass/vim-matchup",
  setup = function()
    vim.g.matchup_matchparen_offscreen = { method = "popup" }
    -- vim.g.matchup_matchparen_offscreen = { method = "status" }
  end
}
