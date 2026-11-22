{ config, pkgs, nixosRepo, ... }:

{
  home.packages = [
    pkgs.zsh
    pkgs.starship
  ];

  home.file.".zshenv".text = ''
    export ZDOTDIR="$HOME/.config/zsh"
    export STARSHIP_CONFIG="$HOME/.config/zsh/starship.toml"
  '';

  xdg.configFile."zsh".source = config.lib.file.mkOutOfStoreSymlink "${nixosRepo}/modules/core/zsh/config";
}
