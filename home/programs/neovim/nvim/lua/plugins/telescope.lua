return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      file_ignore_patterns = {
        "/.git/",
        "/bin/",
        "/obj/",
        "^.git/",
        "^bin/",
        "^node_modules/",
        "^obj/",
        "^public/",
      },
    },
  },
}
