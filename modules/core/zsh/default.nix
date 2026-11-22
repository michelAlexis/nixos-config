{ config, pkgs, nixosRepo, ... }:

{
  home.packages = [
    pkgs.zsh
    pkgs.starship
  ];

  home.file.".zshenv".text = ''
    export ZDOTDIR="$HOME/.config/zsh"
    export STARSHIP_CONFIG="$HOME/.config/zsh/starship.toml"

    # herdr-app, hc and other user-installed binaries
    typeset -U path
    path=("$HOME/.local/bin" $path)
  '';

  xdg.configFile."zsh".source = config.lib.file.mkOutOfStoreSymlink "${nixosRepo}/modules/core/zsh/config";
}
