{
  flake.modules.homeManager.alpha = {
    programs.zsh.shellAliases = {
      cfc = "vim $HOME/dotfiles/modules/alpha/configurations.nix";
      cfh = "vim $HOME/dotfiles/modules/alpha/home.nix";
      cfg = "vim $HOME/dotfiles/modules/git.nix";
      cfz = "vim $HOME/dotfiles/modules/alpha/zsh.nix";
      rf = "home-manager switch --flake ~/dotfiles/#alpha; source ~/.config/zsh/.zshrc";
      rs = "sudo nixos-rebuild switch --flake ~/dotfiles/#alpha";
      ru = "pushd ~/dotfiles; nix flake update; rf; popd";
    };
  };
}
