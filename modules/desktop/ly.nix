{ pkgs, ... }:

{
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix";
      save = true;
    };
  };

  # Важно для работы твоего .xinitrc из Home Manager
  services.xserver.displayManager.startx.enable = true;
}
