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
      #Ai
      "opencode"

      #grafika szar
      "glfw"
      "glm"

      #kszk levlista service
      "poetry"

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

      #Egyetem
      "vlc"

      #IDEs
      "vscodium"

      # Productivity
      "orbstack"
      "opencode-desktop"
      "obsidian"

      #remote desktop
      "rustdesk"

      # Drive
      "seafile-client"
      "onedrive"
      "seadrive"

      #chat
      "mattermost"

      #devtools
      "postman"
      "tableplus"
      "clion"
      "wireshark-app"

      #passwords
      "bitwarden"
    ];



    masApps = {
       "Tailscale" = 1475387142;
       "Windows App" = 1295203466;
       "Microsoft Word" = 462054704;    #fúj
    };
  };

  # System settings
  security.pam.services.sudo_local.touchIdAuth = true;
  system.startup.chime = false;

  power.sleep.display = 10;

  system.defaults = {
    dock = {
      expose-group-apps = true;
      autohide = false;
      magnification = true;
      show-recents = false;
      tilesize = 25;
      largesize = 40;
      persistent-apps = [
          "/Applications/Warp.app"
          "/Applications/Brave Browser.app"
      ];
      persistent-others = [];
      mineffect = "scale";
      mru-spaces = false;
    };

    loginwindow = {
      SHOWFULLNAME = false;
      SleepDisabled = false;
      RestartDisabled = false;
      ShutDownDisabled = false;
      LoginwindowText = "nix darwin flake build";
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
      askForPasswordDelay = 0;
      askForPassword = true;
    };

    finder = {
      ShowPathbar = true;
      FXPreferredViewStyle = "Nlsv";
      FXRemoveOldTrashItems = true;
      ShowStatusBar = true;
      AppleShowAllFiles = true;
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

      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;

      screencapture = {
        target = "clipboard";
      };

      WindowManager = {
        StandardHideWidgets = true;
      };

      CustomUserPreferences = {
          "com.apple.Spotlight" = {
            MenuItemHidden = true;
          };
          "com.apple.controlcenter" = {
            VPN = 18;
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
