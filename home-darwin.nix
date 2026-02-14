{ config, lib, pkgs, programs, ... }:

{
  home.username = "bence";
  home.stateVersion = "25.05";


  home.packages = with pkgs; [
    # DevOps & Infrastructure
    terraform
    kubernetes-helm
    k9s
    kubectx
    flux
    lazydocker


    # Programming Languages & Runtimes
    nodejs
    pnpm
    openjdk
    python313

    # Version Control & Git Tools
    lazygit


    # Editors
    gemini-cli

    # Tool for setting default browser
    duti
  ];

  # Set Brave as default browser after Home Manager activation
  home.activation.setDefaultBrowser = lib.hm.dag.entryAfter ["writeBoundary"] ''
    # Use duti to directly set the default browser using its bundle ID for http and https.
    ${pkgs.duti}/bin/duti -s com.brave.Browser http || true
    ${pkgs.duti}/bin/duti -s com.brave.Browser https || true
  '';


  programs.brave = {
     enable = true;
     commandLineArgs = [
     ];
     extensions = [
         "pejdijmoenmkgeppbflobdenhhabjlaj"
       ];
  };

  programs.zsh = {
    enable = true;  # Fontos, hogy engedélyezd a zsh menedzselését
    shellAliases = {
      oc = "sudo opencode";
      g = "gemini";
      k = "kubectl";
      rebuild = "sudo darwin-rebuild switch --flake /Users/bence/nix";
    };
  };

  programs.home-manager.enable = true;

}
