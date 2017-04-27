# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

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
      synaptics = {
        enable = true;
    	vertEdgeScroll = true;
      };

      displayManager = {
        lightdm.enable = true;
        gdm.enable = false;
        sddm.enable = false;
      };

      desktopManager = {
        plasma5.enable = true;
        gnome3 = {
          enable = false;
          sessionPath = [ pkgs.libgtop pkgs.gnome3.file-roller ];
        };
      };

    };
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  # system.stateVersion = "16.03";

}
