{ pkgs, config, lib, ... }:
with lib;
let cfg = config.dsn.inputrc;
in {

  options.dsn.inputrc = { enable = mkEnableOption "Enable inputrc"; };

  config = mkIf cfg.enable {
    home.file."${config.home.homeDirectory}/.inputrc".text = ''
      set show-all-if-ambiguous on
      set completion-ignore-case on
      set mark-directories on
      set mark-symlinked-directories on
      set match-hidden-files off
      set visible-stats on
      set keymap vi
      set editing-mode vi-insert
    '';
  };
}

