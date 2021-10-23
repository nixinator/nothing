# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:


let
  config = { allowUnfree = true; };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #./matrix.nix
      #./hydra.nix
      "${inputs.self}/avahi.nix"
      "${inputs.self}/libvirt.nix"
      "${inputs.self}/herc.nix"
    ];

   #install flox
   #services.flox.substituterAdded = true;
  #programs.systemtap.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # required for ZFS
  networking.hostId = "093f03ec";

  # enable ntfs filesystem driver
  boot.supportedFilesystems = [ "ntfs" "zfs" ];

  #boot.kernelPackages = unstable.linuxPackages_latest;

  networking.hostName = "z620"; # Define your hostname.

  networking.extraHosts =
  ''
    127.0.0.1 riot.astral
    127.0.0.1 matrix.astral
  '';

  #services.gogs.enable = true;
  #services.gogs.useWizard = true;


  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;
  networking.interfaces.enp1s0.useDHCP = true;
  #networking.interfaces.enp6s0.useDHCP = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
   i18n = {
     consoleFont = "Lat2-Terminus16";
     consoleKeyMap = "uk";
     defaultLocale = "en_US.UTF-8";
   };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     wget vim firefox obs-studio git nmap wireshark 
     element-web pciutils glxinfo
     steam starship
     vscodium
   ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 3000 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
   sound.enable = true;
   hardware.pulseaudio.enable = true;
   hardware.pulseaudio.support32Bit = true;

  # Enable the X11 windowing system.
   services.xserver.enable = true;
   services.xserver.layout = "gb";
   services.xserver.xkbOptions = "eurosign:e";
   #services.xserver.videoDrivers = [ "nvidiaLegacy390" ];
   services.xserver.videoDrivers = [ "nvidia" ];

  # opengl support
   hardware.opengl.driSupport32Bit = true;
   hardware.opengl.enable = true;
   hardware.steam-hardware.enable = true;
 
   programs.steam.enable = true;
  

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
   services.xserver.displayManager.sddm.enable = true;
   services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.l33 = {
     isNormalUser = true;
     extraGroups = [ "wheel" "dialout" ]; # Enable ‘sudo’ for the user.
   };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "l33" ];

 services.udev.extraRules = ''
   SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11",  MODE="0664", GROUP="dialout"
'';

  nixpkgs.config.allowUnfree = true;

  
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };

  nix.buildMachines = [
    { hostName = "localhost";
      system = "x86_64-linux";
      supportedFeatures = ["kvm" "nixos-test" "big-parallel" "benchmark"];
      maxJobs = 8;
    }
  ];
 
  

}

