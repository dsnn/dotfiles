{ config, ... }:
{
  text.gitignore = ''
    *.log
    *.qcow2
    .DS_Store
    .luarc.json
    .uuid
    .vagrant/
    .zcompdump
    history
    node_modules/
    package-lock.json
    named.conf.key
    .env
    **/*/*.secrets*
    .idea
    .direnv
    .envrc
  '';

  perSystem =
    { pkgs, ... }:
    {
      files.files = [
        {
          path_ = ".gitignore";
          drv = pkgs.writeText ".gitignore" config.text.gitignore;
        }
      ];
    };
}
