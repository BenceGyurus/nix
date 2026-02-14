# My Nix Configuration for macOS

This repository contains my personal Nix configuration for macOS, managed with `nix-darwin` and `home-manager`.

## Prerequisites

Before applying this configuration, ensure you have the following installed:

*   **Nix:** The package manager used to build and manage the system.
*   **nix-darwin:** To manage macOS configuration with Nix.
*   **Home Manager:** To manage user-specific configurations.

## File Structure

*   `flake.nix`: The main flake for the configuration, defining all the inputs and the structure of the system. It pulls in `nixpkgs`, `nix-darwin`, `home-manager`, and `nix-homebrew`.
*   `darwin.nix`: System-level configuration for `nix-darwin`. This includes system-wide settings, Homebrew packages, and other global configurations.
*   `home-darwin.nix`: User-level configuration for `home-manager`. This includes user-specific packages, shell aliases, and application settings.

## Installed Software

### Applications (via Homebrew Casks)

*   **Browsers**:
    *   Brave Browser
*   **Utilities**:
    *   Raycast
    *   Flux
    *   Hidden Bar
    *   Warp
    *   Stats
*   **IDEs**:
    *   Zed
*   **Productivity**:
    *   OrbStack
    *   OpenCode Desktop
*   **Drive**:
    *   Seafile Client

### Command-Line Tools (via Homebrew)

*   `opencode`

### Command-Line Tools (via Nix)

*   **DevOps & Infrastructure**:
    *   `terraform`
    *   `kubernetes-helm`
    *   `k9s`
    *   `kubectx`
    *   `flux`
    *   `lazydocker`
*   **Programming Languages & Runtimes**:
    *   `nodejs`
    *   `pnpm`
    *   `openjdk`
    *   `python313`
*   **Version Control & Git Tools**:
    *   `lazygit`
    *   `gh` (GitHub CLI)
*   **Editors**:
    *   `gemini-cli`
*   **Utilities**:
    *   `duti` (for setting default browser)

### Mac App Store Apps

*   Tailscale
*   Windows App
*   Xcode

## Custom Configurations

### Zsh Aliases

The following aliases are defined in `home-darwin.nix`:

*   `oc`: `sudo opencode`
*   `g`: `gemini`
*   `k`: `kubectl`
*   `rebuild`: `sudo darwin-rebuild switch --flake /Users/bence/nix`
*   `gc`: `nix-collect-garbage -d`

### Brave Browser

*   **Default Browser**: Brave is set as the default browser for `http` and `https` protocols using `duti`.
*   **Extensions**: The configuration installs the "iCloud Passwords" extension.

### Zed Editor

*   **Extensions**: The configuration installs extensions for `nix`, `python`, and `javascript`.
*   **Settings**: Various settings are configured, including the theme, keymap (VSCode), and terminal settings.

### System Settings

The `darwin.nix` file includes several system customizations:

*   **Touch ID for `sudo`**: Enabled.
*   **Startup Chime**: Disabled.
*   **Dock**: Customized with specific applications and settings.
*   **Finder**: Path bar is shown, and items in the trash are removed automatically.
*   **Screensaver**: Password is required.
*   **Control Center**: Several items are hidden from the menu bar.
*   **Screencapture**: Default target is the clipboard.
*   **Spotlight**: Menu item is hidden.

## Garbage Collection

The system is configured to automatically run Nix's garbage collector to delete packages older than 10 days. This helps to free up disk space. You can also manually run the garbage collector with the `gc` alias.

## How to Apply the Configuration

To apply the configuration, run the following command from the root of this repository:

```bash
sudo darwin-rebuild switch --flake .
```

Alternatively, you can use the `rebuild` alias if you have sourced the zsh configuration.
