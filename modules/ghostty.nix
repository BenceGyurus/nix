{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    package = null;

    settings = {
      theme = "catppuccin-mocha";
      font-family = "JetBrainsMono Nerd Font";
      font-size = 20;
      window-decoration = false;
      window-padding-x = 20;
      window-padding-y = 20;
      background-opacity = 1;
      background-blur-radius = 20;
      cursor-style = "block";
      cursor-style-blink = true;
      macos-titlebar-style = "hidden";
      env = "TERM=xterm-256color";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}