{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      "${inputs.self}/avahi.nix"
      "${inputs.self}/sharedprograms.nix"
      ./luks.nix
      ./modules/intelgpu.nix
      ./modules/trackpad.nix
      ./modules/blacklistRadeon.nix
    ];

  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "starship";
    networkmanager.enable = true; 
  };

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  services = {
    xserver = { 
      enable = true;
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
    };
  };

  users.users.l33 = {
    isNormalUser = true;
    extraGroups = [ "wheel" "dialout" ];
  };

  system.stateVersion = "22.05";
}

