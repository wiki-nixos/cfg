{
  pkgs,
  config,
  ...
}:
with config.commands; {
  imports = [
    ./yazi.nix
    ./pistol.nix
  ];

  home.persistence."/persist/home/kiara".directories = [
    ".config/Thunar"
    ".config/Nextcloud"
    ".local/share/Nextcloud"
  ];

  home.packages = with pkgs; [
    ## compression
    unar

    ## file sharing
    nextcloud-client

    # security
    rage
    sops
    gnome.seahorse
  ];
}
