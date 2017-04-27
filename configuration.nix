# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
    wine.build = "wine32";
  };

  hardware = {
    bluetooth.enable = true;
    pulseaudio.enable = true;
    cpu.intel.updateMicrocode = true;
    enableAllFirmware = true;
    opengl = {
      driSupport32Bit = true;
      s3tcSupport = true;
      extraPackages = [ pkgs.vaapiIntel ];
    };
  };

  # Use the gummiboot efi boot loader.
  boot = {
    supportedFilesystems = [ "ntfs-3g" ];
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };

  networking = {
    firewall.enable = false;
    networkmanager.enable = true;
    extraHosts =
      ''
      127.0.0.1 local.ubix.io
      '';
  };

  i18n = {
    consoleKeyMap = "dvorak";
    defaultLocale = "en_US.UTF-8";
  };

  programs.bash.enableCompletion = true;

  time.timeZone = "Europe/Bucharest";

  environment = {
    systemPackages = with pkgs; [
    ];
    etc = {
      lfs_version = {
        text = "fake Linux from scratch file hoping to fool getos.js";
      };
    };
    # gnome3.packageSet = pkgs.gnome3_20;
  };

  services = {
    thermald.enable = true;

    mongodb = {
      enable = true;
      extraConfig =
        ''
        storage.mmapv1.smallFiles: true
        '';
    };

    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "dvorak";
      exportConfiguration = true;
    };
  };

  containers = {
    ubixServices = {
      config =
        { config, pkgs, ... }:
        {
          services.zookeeper = {
            enable = true;
          };
          services.apache-kafka = {
            enable = true;
          };
        };
    };
  };

  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
    extraOptions = "--insecure-registry registry.ubix.io:5000";
  };

  users.extraUsers.g = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    uid = 1000;
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  # system.stateVersion = "16.03";

}
