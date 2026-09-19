{ config, pkgs, ... }:

{
  # Required by home manager
  home.stateVersion = "26.05";

  home.username = "ami";
  home.homeDirectory = "/home/ami";

  imports = [
    ./modules/applications/1password
  ];
}
