{ config, inputs, pkgs, nixosRepo, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia.enable = true;
}
