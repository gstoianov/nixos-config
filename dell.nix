{ config, pkgs, ... }:

{
  boot = {
    loader.grub = {
      enable = true;
      version = 2;
      # Define on which hard drive you want to install Grub.
      device = "/dev/sda";
      useOSProber = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking = {
    hostName = "nixos-dell";
    extraHosts =
      ''
      127.0.0.1 nixos-dell
      '';
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
  };

  services.xserver = {
    displayManager = {
      lightdm.enable = false;
      gdm.enable = true;
      sddm.enable = false;
    };

    desktopManager = {
      plasma5.enable = false;
      gnome3 = {
        enable = true;
        sessionPath = [ pkgs.libgtop pkgs.gnome3.file-roller pkgs.p7zip ];
      };
    };

    windowManager = {
      xmonad = {
        enable = false;
        enableContribAndExtras = true;
      };
    };
  };

}
