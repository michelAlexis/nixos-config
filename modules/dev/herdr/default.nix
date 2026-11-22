{ pkgs, inputs, config, nixosRepo, ... }:

{
  home.packages = [
    inputs.herdr-nix.packages.${pkgs.system}.default
  ];

  # Desktop app config, a git submodule shared with the Windows machine
  xdg.configFile."herdr-app".source = config.lib.file.mkOutOfStoreSymlink "${nixosRepo}/modules/dev/herdr/app-config";
  xdg.configFile."herdr".source = config.lib.file.mkOutOfStoreSymlink "${nixosRepo}/modules/dev/herdr/config";
}
