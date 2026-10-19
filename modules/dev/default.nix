{ pkgs, inputs, ... }:

{
  home.packages = [
    pkgs.lazygit
    pkgs.lazydocker
  ];
}
