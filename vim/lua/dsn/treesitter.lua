require'nvim-treesitter.configs'.setup {
  ensure_installed = {
      "graphql",
      "html",
      "bash",
      "python",
      "json",
      "latex",
      "lua",
      "c_sharp",
      "typescript",
      "tsx",
      "javascript",
      "yaml",
      "comment",
      "css",
      "jsdoc",
      "regex",
      "jsonc"
  },
  context_commentstring = {
    enable = true,
  },
  highlight = { enable = true },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}

-- Keybindings
-- R: Refreshes the playground view when focused or reloads the query when the query editor is focused.
-- o: Toggles the query editor when the playground is focused.
-- a: Toggles visibility of anonymous nodes.
-- i: Toggles visibility of highlight groups.
-- I: Toggles visibility of the language the node belongs to.
-- t: Toggles visibility of injected languages.
-- f: Focuses the language tree under the cursor in the playground. The query editor will now be using the focused language.
-- F: Unfocuses the currently focused language.
-- <cr>: Go to current node in code buffer
