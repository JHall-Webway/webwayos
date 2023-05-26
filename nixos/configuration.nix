{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nixpkgs = { 
    hostPlatform = lib.mkDefault "x86_64-linux";
    config.allowUnfree = true;
  };

  hardware.keyboard.zsa.enable = true;

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

  environment.systemPackages = with pkgs; [ home-manager ];

  users.users.jhall = { isNormalUser = true;
    description = "James Hall";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  security.rtkit.enable = true;


  sound.enable = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Mononoki" ]; })
  ];

  services = { 
    openssh.enable = true;
    xserver = { enable = true;
      libinput.enable = true;
      displayManager = {
        sddm.enable = true;
        defaultSession = "none+awesome";
      };
      windowManager.awesome = { enable = true;
        luaModules = with pkgs.luaPackages; [
          luarocks
          luadbi-mysql
        ];
      };
      layout = "us";
      xkbVariant = "";
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
    firewall = { enable = true;
      allowedTCPPorts = [ 3389 ];
    };
  };
}
