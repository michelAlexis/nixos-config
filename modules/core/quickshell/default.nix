{ config, pkgs, nixosRepo, inputs, ... }:

{
  home.packages = [
    inputs.quickshell.packages.${pkgs.system}.default
  ];

  # home.packages.quickshell.enable = true;

  xdg.configFile."quickshell".source = config.lib.file.mkOutOfStoreSymlink "${nixosRepo}/modules/core/quickshell/config";
}
