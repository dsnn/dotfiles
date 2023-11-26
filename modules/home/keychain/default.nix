{ pkgs, ...}: {
  programs.keychain.enable = true;
  programs.keychain.enableZshIntegration = true;
  programs.keychain.extraFlags = [ "--quiet" "--quick" ];
  programs.keychain.agents = [ "ssh" ];
  programs.keychain.keys = [ "id_rsa" ];
}
