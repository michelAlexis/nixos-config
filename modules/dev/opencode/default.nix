{ config, pkgs, nixosRepo, ... }:

{
  home.packages = [
    pkgs.opencode
  ];

  # xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${nixosRepo}/modules/dev/nvim/config";
}
