{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  environment.variables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };

  system = {
    name = "mars";
    stateVersion = "22.11";
  };

  fileSystems."/" = { device = "/dev/disk/by-uuid/77383b16-d836-4b13-b8b3-56f5fc3a97ae";
      fsType = "ext4";
  };

  swapDevices =[{ device = "/dev/disk/by-uuid/daffc091-786f-4317-8192-58393ad71ddb"; }];

  services.xserver.dpi = 180;
  services.k3s.role = "server";

  hardware = {
    bluetooth.enable = true;
    cpu.intel.updateMicrocode = true;
  };

  boot = { 
    loader.grub = { enable = true;
      useOSProber = true;
      device = "/dev/sda";
    };
    initrd = { 
      availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
      kernelModules = [ ];
    };
    kernelModules = [ ];
    extraModulePackages = [ ];
  };

  powerManagement = { enable = true;
    cpuFreqGovernor = lib.mkDefault "ondemand";
  };
  networking = { hostName = "mars";
    interfaces = { 
      wlo1 = { 
        useDHCP = lib.mkDefault true;
      };
    };
  };
}
