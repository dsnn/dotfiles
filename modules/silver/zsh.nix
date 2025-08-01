{
  flake.modules.homeManager.silver = {
    programs.zsh = {
      initContent = ''
        function run_nvim() {
          BUFFER="nvim && clear"
          zle accept-line
        }
        zle -N run_nvim
        bindkey "^n" run_nvim
      '';

      shellAliases = {
        cfc = "vim $HOME/dotfiles/modules/silver/configurations.nix";
        cfh = "vim $HOME/dotfiles/modules/silver/home.nix";
        cfg = "vim $HOME/dotfiles/modules/git.nix";
        cfz = "vim $HOME/dotfiles/modules/silver/zsh.nix";
        rf = "home-manager switch --flake ~/dotfiles/#silver; source ~/.config/zsh/.zshrc";
        rs = "sudo darwin-rebuild switch --flake ~/dotfiles/#silver";
        ru = "pushd ~/dotfiles; nix flake update; rf; popd";
      };
    };
  };
}
