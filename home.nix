{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withPython3 = false;
    withRuby = false;
  };

  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "docker"
        "npm"
        "rust"
        "you-should-use"
        "zsh-autosuggestions"
        "zsh-syntax-highlighting"
        "zsh-bat"
      ];
    };
  };


  home.stateVersion = "24.05";
}
