{ pkgs, lib, config, ... }:
{
   environment.systemPackages = with pkgs; [
     cowsay
     vim
     git
   ];
}


