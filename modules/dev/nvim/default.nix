{ config, pkgs, nixosRepo, ... }:

{
  home.packages = [
    pkgs.neovim
    pkgs.tree-sitter
    pkgs.fzf
    pkgs.stylua
  ];

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${nixosRepo}/modules/dev/nvim/config";
}
