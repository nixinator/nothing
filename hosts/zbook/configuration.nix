# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "zbook"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.wifi.scanRandMacAddress = false;
 

  #nixpkgs.config.allowUnfree = true; 

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s25.useDHCP = true;
  networking.interfaces.wlp61s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
   i18n = {
     consoleFont = "Lat2-Terminus16";
     consoleKeyMap = "us";
     defaultLocale = "en_US.UTF-8";
   };

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget vim brave firefox 
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
   services.xserver.enable = true;
   services.xserver.layout = "us";
   services.xserver.xkbOptions = "eurosign:e";

  # try nvida driver for laptop instead of noveau driver
  # services.xserver.videoDrivers = [ "nvidia" ];

  # Enable touchpad support.
   services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
   services.xserver.displayManager.sddm.enable = true;
   services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.bob = {
     isNormalUser = true;
     extraGroups = [ "wheel" "vboxusers" ]; # Enable ‘sudo’ for the user.
   };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "21.05"; # Did you read the comment?

  virtualisation.virtualbox.host.enable = true;
  

}

