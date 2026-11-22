{ config, nixosRepo, ... }:

{
  home.file.".XCompose".source =
    config.lib.file.mkOutOfStoreSymlink "${nixosRepo}/modules/core/keyboard/config/XCompose";
}
