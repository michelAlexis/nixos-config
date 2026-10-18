{ config, pkgs, nixosRepo, ... }:

{
  home.packages = [
    pkgs.opencode
  ];

  xdg.configFile."opencode".source = config.lib.file.mkOutOfStoreSymlink "${nixosRepo}/modules/dev/opencode/config";
}
