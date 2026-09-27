{ config, pkgs, ... }:

{
  home.packages = [
    pkgs._1password-gui
  ];
  

  home.file.".ssh/config".source = ./ssh-config;
}
