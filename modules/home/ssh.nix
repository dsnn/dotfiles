{ lib, config, ... }:
with lib;
let cfg = config.dotfiles.ssh;
in {
  options.dotfiles.ssh = {
    enable = mkEnableOption "Enable ssh";
    greeter = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {

    programs.ssh.enable = true;
    programs.ssh.includes = [ "${config.home.homeDirectory}/.ssh/config.d/*" ];
    programs.ssh.forwardAgent = true;
    programs.ssh.extraConfig = ''
      IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    '';

    home.file."${config.home.homeDirectory}/.ssh/config.d/sshconfig.secrets".source =
      ../../secrets/sshconfig.secrets;
  };
}
