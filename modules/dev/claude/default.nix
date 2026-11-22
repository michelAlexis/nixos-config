{ config, pkgs, nixosRepo, ... }:

{
  home.packages = [
    pkgs.claude-code
  ];

  # That is outside ~/.config, so it has to be home.file, not xdg.configFile.
  home.file.".claude".source = config.lib.file.mkOutOfStoreSymlink "${nixosRepo}/modules/dev/claude/config";

  # ~/.claude.json is separate and holds user-scope MCP servers, project
  # trust, the OAuth account and other machine-specific state. Claude
  # rewrites it constantly, so linking it into the repo is optional.
  # Uncomment if you want to version it (and gitignore the secrets):
  #
  # home.file.".claude.json".source = config.lib.file.mkOutOfStoreSymlink "${nixosRepo}/modules/dev/claude/claude.json";
}
