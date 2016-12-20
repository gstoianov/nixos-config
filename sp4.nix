{ config, pkgs, ... }:

{
  boot = {
    loader = {
      grub.enable = false;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # kernelPackages = pkgs.linuxPackages_4_8;
    kernelPackages = pkgs.linuxPackagesFor pkgs.linux_mssp4;
  };

  hardware = {
    firmware = [ pkgs.intel-ipts-firmware ];
  };

  i18n = {
    # consoleFont = "Lat2-Terminus16";
    consoleFont = "sun12x22";
  };

  environment.systemPackages = [
    # pkgs.kde5.kmix
    pkgs.kde5.okular
  ];

  services.xserver = {
    multitouch.enable = true;

    displayManager = {
      lightdm.enable = true;
      gdm.enable = false;
      sddm.enable = false;
    };

    desktopManager = {
      kde5.enable = true;
      gnome3 = {
        enable = false;
        sessionPath = [ pkgs.libgtop pkgs.gnome3.file-roller ];
      };
    };

    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };
  };

  networking = {
    hostName = "nixos-sp4";
    extraHosts =
      ''
      127.0.0.1 nixos-sp4
      '';
  };

}
