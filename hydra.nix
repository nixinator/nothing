{ pkgs, config, ... } :
{
  services.hydra = {
    enable = true;
    hydraURL = "http://localhost:3000";
    notificationSender = "hydra@localhost";
    buildMachinesFiles = [/etc/nix/machines];
    useSubstitutes = false;
    package = pkgs.hydra-unstable;
  };
nix.trustedUsers = [ "root" "hydra" "l33"  "hydra-evaluator" "hydra-queue-runner" ];

services.nix-serve = {
  enable = true;
  secretKeyFile = "/var/cache-priv-key.pem";
};


}

