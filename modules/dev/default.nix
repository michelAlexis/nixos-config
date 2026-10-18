{ pkgs, inputs, ... }:

{
  home.packages = [
    pkgs.lazygit
    pkgs.lazydocker
    inputs.herdr-nix.packages.${pkgs.system}.default
  ];
}
