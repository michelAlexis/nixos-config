{ config, pkgs, nixosRepo, ... }:

{
  home.packages = [
    pkgs.neovim
    pkgs.tree-sitter
    pkgs.fzf
    # pkgs.stylua
  ];

  # Default app for text files (xdg-open, file pickers, etc.)
 #xdg.mimeApps = {
 #  enable = true;
 #  defaultApplications = {
 #    "text/plain" = "nvim.desktop";
 #    "text/markdown" = "nvim.desktop";
 #    "application/json" = "nvim.desktop";
 #    "application/x-shellscript" = "nvim.desktop";
 #  };
 #};

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${nixosRepo}/modules/dev/nvim/config";
}
