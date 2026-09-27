{ config, pkgs, inputs, ... }:

{

  programs.quickshell = {
    enable = true;
    package = inputs.quickshell.packages.${pkgs.system}.default;
  };

  xdg.configFile."quickshell".source = config.lib.file.mkOutOfStoreSymlink "${nixosRepo}/modules/core/quickshell/config";
}
