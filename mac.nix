{ config, pkgs, ... }:

{
  # Use the gummiboot efi boot loader.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      # gummiboot.enable = true;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "nixos-mac";
    extraHosts =
    ''
    127.0.0.1 nixos-mac
    '';
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
  };

  # Enable the X11 windowing system.
  services = {
    xserver = {
      # synaptics = {
      #   enable = true;
      #   vertEdgeScroll = true;
      # };

      displayManager = {
        lightdm.enable = false;
        gdm.enable = true;
        sddm.enable = false;
      };

      desktopManager = {
        plasma5.enable = false;
        gnome3 = {
          enable = true;
          sessionPath = [ pkgs.libgtop pkgs.gnome3.file-roller ];
        };
      };

    };
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  # system.stateVersion = "16.03";

}
