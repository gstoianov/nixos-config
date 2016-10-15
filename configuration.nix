# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
    # chromium.enablePepperFlash = true;

    packageOverrides = super: let self = super.pkgs; in {
      # linuxPackages_testing = recursesuper.linuxPackages_testing;
      linux_testing1 = super.linux_testing.override {
        kernelPatches = super.linux_testing.kernelPatches ++ [
	  # { patch = ./surface-touchpad.patch; name = "type-cover-4"; }
	  { patch = ./001_typing-cover-k47.patch; name = "typing-cover"; }
	  # { patch = ./002_surfacepro4-button.patch; name = "surfacepro4-button"; }
	  # { patch = ./003_i2c.patch; name = "surfacepro4-i2c"; }
	  # { patch = ./999_fix_kernel_panic_when_mapping_BGRT_data.patch;
	  #   name = "sp4-fix-kernelpanic"; }
	];
      };

      idea14_oracle = super.idea.idea14-community.override {
        jdk = super.oraclejdk8;
      };
      
      idea15_ult_oracle = super.idea.idea-ultimate.override {
        jdk = super.oraclejdk8;
      };
      
      jdk = super.jdk8;
      jdk8 = super.oraclejdk8;
      # jre = pkgs.jre8;
      # jre8 = pkgs.oraclejre8;
    };
  };

  hardware = {
    bluetooth.enable = true;
    cpu.intel.updateMicrocode = true;
    enableAllFirmware = true;
  };

  # Use the gummiboot efi boot loader.

  boot = {
    # kernelModules = [ "hid-multitouch" ];
    # initrd.kernelModules = [ "hid-multitouch" ];
  
    loader = {
      grub.enable = false;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    supportedFilesystems = [ "ntfs-3g" ];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "powersave";

  networking = {
    hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    firewall.enable = false;
    extraHosts = ''
127.0.0.1 local.ubix.io
127.0.0.1 nixos
'';
    # extraHosts = "192.168.99.100 local.ubix.io";
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "dvorak";
    defaultLocale = "en_US.UTF-8";
  };

  programs.bash.enableCompletion = true;

  # Set your time zone.
  time.timeZone = "Europe/Bucharest";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment = {
    systemPackages = with pkgs; [
      wget
      # (emacsWithPackages (with emacsPackagesNg; [
      #   magit haskell-mode melpaPackages.js2-mode nix-mode
      #   melpaPackages.color-theme-solarized
      # ]))
      sublime3
      # idea14_oracle
      idea15_ult_oracle
      maven
      # idea.idea14-community
      bind nix-repl glxinfo pciutils usbutils coreutils
      cabal2nix stack npm2nix
      dmidecode
      chromium
      # google-chrome-beta
      vim vlc mc git
      skype deluge remmina
    ];
    etc = {
      lfs_version = {
        text = "fake Linux from scratch file hoping to fool getos.js";
      };
    };
    # gnome3.packageSet = pkgs.gnome3_18;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  services = {
    # nginx = {
    #   enable = true;
    #   httpConfig = ''
    #     server {
    # 	  listen 80;
    # 	  server_name local.ubix.io;
    # 	  location / {
    # 	    proxy_pass http://127.0.0.1:4086;
    # 	  }
    # 	} 
    #     server {
    # 	  listen 443;
    # 	  server_name local.ubix.io;
    # 	  location / {
    # 	    proxy_pass http://127.0.0.1:4086;
    # 	  }
    # 	} 
    #   '';
    # };
    mongodb = {
      enable = true;
      extraConfig =
      ''
      nojournal = true
      '';
    };
  };

  # virtualisation.docker = {
  #   enable = true;
  #   extraOptions = "--insecure-registry registry.ubix.io:5000";
  # };

  services.thermald.enable = true;
  
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "dvorak";
    # services.xserver.xkbOptions = "eurosign:e";

    displayManager.kdm.enable = false;
    desktopManager.kde5.enable = true;
    
    displayManager.gdm.enable = true;
    desktopManager.gnome3 = {
      enable = true;
      sessionPath = [ pkgs.libgtop ];
    };
    synaptics = {
      enable = true;
      vertEdgeScroll = true;
      # additionalOptions = ''
      #   MatchDevicePath "/dev/input/event*"
      #   Option "vendor" "045e"
      # Option "product" "07e8"
      # '';
    };
    # wacom.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.g = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    uid = 1000;
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  # system.stateVersion = "16.03";

}
