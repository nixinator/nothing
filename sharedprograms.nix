{ pkgs, lib, config, ... }:
{

  # List packages installed in system profile. on all computers that import this file:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     cowsay
   ];


}


