 {
   # Support zfs
   boot.supportedFilesystems = [ "zfs" ];
   networking.hostId = "6ddf4897";

   # Minimal list of modules to use the EFI system partition and the YubiKey
   boot.initrd.kernelModules = [ "vfat" "nls_cp437" "nls_iso8859-1" "usbhid" ];

   # Enable support for the YubiKey PBA
   boot.initrd.luks.yubikeySupport = true;

   # Configuration to use your Luks device
   boot.initrd.luks.devices = {
     "zroot" = {
       device = "/dev/disk/by-id/ata-SPCC_Solid_State_Disk_AD8B079915F200175414-part1";
       preLVM = true; # You may want to set this to false if you need to start a network service first
       yubikey = {
         slot = 2;
         twoFactor = true; # Set to false if you did not set up a user password.
         storage = {
           device = "/dev/disk/by-id/ata-SPCC_Solid_State_Disk_AD8B079915F200175414-part3";
         };
       };
     };
   };
 }
