{
  flake.modules.homeManager.user-dsn =
    { pkgs, ... }:
    {
      home.packages = [
        (pkgs.writeShellApplication {
          name = "gce";

          runtimeInputs = [
            pkgs.gum
            pkgs.git
          ];

          text = ''
            # This script is used to write a conventional commit message.
            TYPE=$(gum choose "add" "fix" "feat" "docs" "style" "refactor" "test" "chore" "revert")
            SCOPE=$(gum input --placeholder "scope")

            # Wrap scope in parentheses if provided
            test -n "$SCOPE" && SCOPE="($SCOPE)"

            SUMMARY=$(gum input --value "$TYPE$SCOPE: " --placeholder "Summary of this change")
            DESCRIPTION=$(gum write --placeholder "Details of this change")

            gum confirm "Commit changes?" && git commit -m "$SUMMARY" -m "$DESCRIPTION"
          '';
        })
      ];
    };
}
