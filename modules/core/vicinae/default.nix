{ config, pkgs, nixosRepo, inputs, ... }:

{
  home.packages = [
    inputs.vicinae.packages.${pkgs.system}.default
  ];

  xdg.configFile."vicinae".source = config.lib.file.mkOutOfStoreSymlink "${nixosRepo}/modules/core/vicinae/config";
}
