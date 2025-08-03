{ config, ... }:
{
  text.gitignore = ''
    **/*/*.secrets*
    *.log
    *.qcow2
    .DS_Store
    .direnv
    .env
    .envrc
    .idea
    .luarc.json
    .uuid
    .zcompdump
    history
    node_modules/
    package-lock.json
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
