{ config, pkgs, nixosRepo, ... }:

{
  home.packages = [
    pkgs._1password-gui
  ];

  #xdg.configFile."ssh".cours = config.lib.file.mkOutOfStoreSymlink 
}
