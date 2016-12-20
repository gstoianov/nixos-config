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

  networking = {
    hostName = "nixos-sp4";
    extraHosts =
      ''
      127.0.0.1 nixos-sp4
      '';
  };

}
