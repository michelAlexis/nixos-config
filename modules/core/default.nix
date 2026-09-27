{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.gcc
    pkgs.bun
    pkgs.ripgrep
    pkgs.unzip
  ];
}
