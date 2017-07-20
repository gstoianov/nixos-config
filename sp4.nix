{ config, pkgs, ... }:

{
  boot = {
    loader = {
      grub.enable = false;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;
    # kernelPackages = pkgs.linuxPackagesFor pkgs.linux_mssp4;
    # kernelModules = [ "hid-multitouch" ];
    # initrd.kernelModules = [ "hid-multitouch" ];
  };

  hardware = {
    # firmware = [ pkgs.intel-ipts-firmware ];
  };

  i18n = {
    # consoleFont = "Lat2-Terminus16";
    consoleFont = "sun12x22";
  };

  environment.systemPackages = [
    pkgs.okular
  ];

  services.xserver = {
    multitouch.enable = true;

    displayManager = {
      lightdm.enable = false;
      gdm.enable = false;
      sddm.enable = true;
    };

    desktopManager = {
      plasma5.enable = true;
      gnome3 = {
        enable = false;
        sessionPath = [ pkgs.libgtop pkgs.gnome3.file-roller ];
      };
    };

    windowManager = {
      xmonad = {
        enable = false;
        enableContribAndExtras = true;
      };
    };
  };

  # nix.binaryCaches = [
  #   "https://cache.nixos.org/"

  #   # This assumes that you use the default `nix-serve` port of 5000
  #   "http://192.168.0.100:5001"
  # ];

  # nix.binaryCachePublicKeys = [
    # "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="

    # Replace the following string with the contents of the
    # `nix-serve.pub` file you generated in the "Server configuration"
    # section above
    # "192.168.0.100:0Hvx/nyjrKng7On9LCqwj4bSxYmiDSscTazXXdIJLFY="
  # ];

  networking = {
    hostName = "nixos-sp4";
    extraHosts =
      ''
      127.0.0.1 nixos-sp4
      '';
  };

}
