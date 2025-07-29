{
  plugins = {
    mini = {
      enable = true;

      modules = {
        bufremove = { };
        comment = {
          mappings = {
            comment = "gc";
            comment_line = "gcc";
            comment_visual = "gc";
            textobject = "gc";
          };
        };
        surround = {
          mappings = {
            add = "sa";
            delete = "sd";
            replace = "sr";
            suffix_last = "l";
            suffix_next = "n";
          };
        };
      };
    };
  };
}
