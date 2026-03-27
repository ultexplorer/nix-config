{ config, pkgs, userName, ... }:
{
  imports = [ 
    ./hardware-configuration.nix
    ../../modules/desktop/xfce.nix
    ../../modules/system/boot.nix
    ../../modules/system/t14-amd.nix
    ../../modules/system/common-packages.nix
    ../../modules/system/hw-tools.nix 
  ];

  ########################################################################
  xdg.portal.enable = true;

  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
  ];



  #######################################################################

  users.users.${userName} = {
    isNormalUser = true;
    group = "users";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "t14";
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [ firefox ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "24.11";

  services.dbus.enable = true;
  security.polkit.enable = true;
  services.xserver.libinput.enable = true;
}
