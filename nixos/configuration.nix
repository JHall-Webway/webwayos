{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nixpkgs = { 
    hostPlatform = lib.mkDefault "x86_64-linux";
    config.allowUnfree = true;
  };

  time.timeZone = "America/Los_Angeles";

  i18n = { 
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    home-manager
    neovim
    git
  ];

  users.users.jhall = { isNormalUser = true;
    description = "James Hall";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  security.rtkit.enable = true;


  sound.enable = true;

  services = { 
    openssh.enable = true;
    xserver = { enable = true;
      layout = "us";
      xkbVariant = "";
      displayManager = { 
        # gdm.enable = true;
	sddm.enable = true;
      };
      windowManager = {
        awesome.enable = true;
        i3 = { enable = true; package = pkgs.i3-gaps; };
      };
      desktopManager = {
        # gnome.enable = true;
	plasma5.enable = true;
      };
    };
    xrdp = { enable = true;
      defaultWindowManager = "startplasma-x11";
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    printing.enable = true;
  };

  networking = {
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 3389 ];
  };
}
