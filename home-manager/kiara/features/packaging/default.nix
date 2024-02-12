{ lib, config, pkgs, inputs, system, ... }:

with lib;

let cfg = config.toggles.packaging;
in {
  options.toggles.packaging.enable = mkEnableOption "packaging";

  # imports = lib.optionals cfg.enable [
  # ];

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ## nix
      dconf2nix
      any-nix-shell
      nix-direnv
      nixpkgs-review
      garn
      devbox

      ## packaging
      nix-software-center
      gnome.gnome-software
      appimage-run
      emacsPackages.guix

      ## config
      gnome.dconf-editor
      nixos-conf-editor
      glib # gsettings

    ];
  };
}
