# Maybe something like this? Work in progress and not tested!
# Could make it a flake, but KISS for now.
{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkOption types mkIf;
  modKeys = import ./modifiers.nix;
  keyCodeType = types.enum ./keycodes.nix;
  modifierType = types.listOf (types.enum modKeys);

in
{
  options.karabiner = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Karabiner JSON generation.";
    };

    rules = mkOption {
      type = types.listOf (
        types.submodule {
          options = {
            description = mkOption {
              type = types.str;
              default = "";
            };

            manipulators = mkOption {
              type = types.listOf (
                types.submodule {
                  options = {
                    type = mkOption {
                      type = types.enum [ "basic" ];
                      default = "basic";
                    };

                    from = mkOption {
                      type = types.submodule {
                        options = {
                          key_code = mkOption {
                            type = keyCodeType;
                          };
                          modifiers = mkOption {
                            type = types.nullOr (
                              types.submodule {
                                options = {
                                  optional = mkOption {
                                    type = modifierType;
                                    default = [ ];
                                  };
                                  mandatory = mkOption {
                                    type = modifierType;
                                    default = [ ];
                                  };
                                };
                              }
                            );
                            default = null;
                          };
                        };
                      };
                    };

                    to = mkOption {
                      type = types.nullOr (
                        types.listOf (
                          types.submodule {
                            options = {
                              key_code = mkOption {
                                type = keyCodeType;
                              };
                              modifiers = mkOption {
                                type = modifierType;
                                default = [ ];
                              };
                            };
                          }
                        )
                      );
                      default = null;
                    };
                  };
                }
              );
            };
          };
        }
      );
      default = [ ];
    };
  };

  config = mkIf config.karabiner.enable {
    home.file.".config/karabiner/karabiner.json" = {
      source = pkgs.writeText "karabiner.json" (
        builtins.toJSON {
          global = {
            check_for_updates_on_startup = false;
            show_in_menu_bar = false;
          };
          profiles = [
            {
              name = "Default";
              selected = true;
              complex_modifications.rules = config.karabiner.rules;
            }
          ];
        }
      );
    };
  };
}
