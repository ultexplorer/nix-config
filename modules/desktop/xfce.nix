{ pkgs, ... }:

{
  services.xserver = {
    enable = true;

    desktopManager.xfce.enable = true;

    displayManager = {
      lightdm.enable = false;
      startx.enable = true;
    };

    libinput.enable = true;

    xkb = {
      layout = "us,ru";
      options = "grp:alt_shift_toggle";
    };
  };
}
