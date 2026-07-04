{ config, lib, pkgs, programs, ... }:

let
  jdk = pkgs.jdk25;
  jdkHome = "${jdk}"; 
in
{
  home.username = "bence";
  home.stateVersion = "25.05";

  imports = [./modules/ghostty.nix];

  home.sessionVariables = {
    PAGER = "less";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  };


  home.packages = with pkgs; [
    # DevOps & Infrastructure
    terraform
    kubernetes-helm
    k9s
    kubectl
    kubectx
    flux
    lazydocker
    gh
    talosctl
    docker

    # Programming Languages & Runtimes
    nodejs
    pnpm
    jdk25
    maven
    python313
    go
    chatgpt

    # Version Control & Git Tools
    lazygit
    
    appcleaner

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

  home.sessionVariables = {
    JAVA_HOME = jdkHome;
  };

  home.file."Library/Application Support/VSCodium/User/settings.json".text =
    builtins.toJSON {
      "java.jdt.ls.java.home" = jdkHome;
      "java.configuration.runtimes" = [
        {
          name = "JavaSE-25";
          path = jdkHome;
          default = true;
        }
      ];
    };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "catppuccin-mocha";
    };
  };

  programs.zsh = {
    enable = true;  # Fontos, hogy engedélyezd a zsh menedzselését
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "eza --icons";
      ll = "eza -l --icons --git";
      lt = "eza --tree --icons";
      cat = "bat";
      oc = "opencode";
      g = "npx gemini";
      k = "kubectl";
      rebuild = "sudo darwin-rebuild switch --flake /Users/bence/nix";
      gc = "sudo nix-collect-garbage -d && sudo nix-store --optimise && sudo darwin-rebuild switch --flake /Users/bence/nix";
      u = "nix flake update --flake /Users/bence/nix && sudo darwin-rebuild switch --flake /Users/bence/nix && sudo nix-collect-garbage -d && sudo nix-store --optimise";
    };
  };

  # programs.zed-editor = {
  #   enable = true;
  #   extensions = [ "nix" "python" "javascript" "go" ];
  #   userSettings = {
  #     theme = {
  #       mode = "system";
  #       dark = "One Dark";
  #       light = "One Light";
  #     };
  #     hour_format = "hour24";
  #     vim_mode = false;

  #     load_direnv = "shell_hook";
  #     base_keymap = "VSCode";

  #     assistant = {
  #       enabled = false;
  #     };

  #     terminal = {
  #           alternate_scroll = "off";
  #           blinking = "off";
  #           copy_on_select = false;
  #           dock = "bottom";
  #           detect_venv = {
  #             on = {
  #               directories = [ ".env" "env" ".venv" "venv" ];
  #               activate_script = "default";
  #             };
  #           };
  #           env = {
  #             TERM = "alacritty";
  #           };
  #           line_height = "comfortable";
  #           option_as_meta = false;
  #           button = false;
  #           shell = "system";
  #           toolbar = {
  #             title = true;
  #           };
  #           working_directory = "current_project_directory";
  #         };


  #   };
  # };

  programs.home-manager.enable = true;

}
