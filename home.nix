



{ config, pkgs, ... }:

{
  # Required by home manager
  home.stateVersion = "26.05";

  home.username = "ami";
  home.homeDirectory = "/home/ami";

  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo I use nixos btw";
    };
  };
}
