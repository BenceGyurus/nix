{ pkgs, ... }:

{

  # System version
  system.stateVersion = 5; # macOS Sequoia

  # Nix settings
  nixpkgs.config.allowUnfree = true;

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    # Garbage collection
    gc = {
      automatic = true;
      options = "--delete-older-than 10d";
    };


  };

  # Brew packages
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap"; # zap removes all not defined casks, set it to "disabled" to keep them

    brews = [
      "opencode"
    ];

    casks = [
      # Browsers
      "brave-browser"

      # Utilities
      "raycast"
      "flux-app"
      "hiddenbar"
      "warp"
      "stats"

      #IDEs
      "zed"

      # Productivity
      "orbstack"
      "opencode-desktop"

      #remote desktop
      "rustdesk"

      # Drive
      "seafile-client"
      "onedrive"
      "seadrive"

      #chat
      "mattermost"
    ];



    masApps = {
       "Tailscale" = 1475387142;
       "Windows App" = 1295203466;
    };
  };

  # System settings
  security.pam.services.sudo_local.touchIdAuth = true;
  system.startup.chime = false;

  system.defaults = {
    dock = {
      autohide = false;
      magnification = true;
      show-recents = false;
      tilesize = 25;
      largesize = 40;
      persistent-apps = [
          "/Applications/Warp.app"
          "/Applications/Zed.app"
          "/Applications/Brave Browser.app"
      ];
      persistent-others = [];
      mineffect = "scale";
      mru-spaces = false;
    };


    controlcenter = {
      BatteryShowPercentage = false;
      Bluetooth = false;
      Display = false;
      FocusModes = false;
      NowPlaying = false;
      Sound = false;
      AirDrop = false;
    };

    screensaver = {
      askForPassword = true;
    };

    finder = {
      ShowPathbar = true;
      FXPreferredViewStyle = "Nlsv";
      FXRemoveOldTrashItems = true;
    };

    NSGlobalDomain = {
        AppleInterfaceStyleSwitchesAutomatically = true;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticInlinePredictionEnabled = false;
        NSTableViewDefaultSizeMode = 1;
        NSDisableAutomaticTermination = true;
      };

      WindowManager = {
        AppWindowGroupingBehavior = true;
      };

      screencapture = {
        target = "clipboard";
      };

      CustomUserPreferences = {
          "com.apple.Spotlight" = {
            MenuItemHidden = true;
          };
        };

  };


  # User settings
  users.users.bence = {
    home = "/Users/bence";
    shell = pkgs.zsh;
  };

  system.primaryUser = "bence";



}
