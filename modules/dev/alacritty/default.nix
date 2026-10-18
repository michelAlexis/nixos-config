{ config, pkgs, nixosRepo, ... }:

{
  home.packages = [
    pkgs.alacritty
  ];

  xdg.configFile."alacritty".source = config.lib.file.mkOutOfStoreSymlink "${nixosRepo}/modules/dev/alacritty/config";
}
