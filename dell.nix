{ config, pkgs, ... }:

{
  boot = {
    loader.grub = {
      enable = true;
      version = 2;
      # Define on which hard drive you want to install Grub.
      device = "/dev/sda";
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

}
