{ config, pkgs, nixosRepo, ... }:

{
  home.packages = [
    pkgs.lazygit
    pkgs.lazydocker
  ];

  # xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${nixosRepo}/modules/dev/nvim/config";
}
