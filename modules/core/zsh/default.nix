{ config, pkgs, nixosRepo, ... }:

{
  home.packages = [
    pkgs.zsh
  ];

  # Point zsh to ~/.config/zsh
  home.file.".zshenv".text = ''
    export ZDOTDIR="$HOME/.config/zsh"
  '';

  xdg.configFile."zsh".source = config.lib.file.mkOutOfStoreSymlink "${nixosRepo}/modules/core/zsh/config";
}
