{ pkgs, inputs, config, nixosRepo, ... }:

{
  home.packages = [
    inputs.herdr-nix.packages.${pkgs.system}.default
  ];

  xdg.configFile."herdr".source = config.lib.file.mkOutOfStoreSymlink "${nixosRepo}/modules/dev/herdr/config";
}
