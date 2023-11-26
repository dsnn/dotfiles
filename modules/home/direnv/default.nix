{ pkgs, ...}:{

  # programs.zsh.initExtra = ''
  #   if command -v direnv &> /dev/null
  #   then
  #     eval "$(direnv hook zsh)"
  #   fi
  # '';

  programs.direnv.enable = true;
}
