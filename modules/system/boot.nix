{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [ "quiet" "splash" "loglevel=3" ];

  # Настройки консоли (TTY)
  console = {
    enable = true;
    font = "ter-v32n"; # Крупный шрифт (Terminus)
    packages = [ pkgs.terminus_font ];
    
    keyMap = "us";     # Оставляем английскую раскладку по умолчанию
  };

  # Системный язык (можешь оставить ru или поставить en)
  i18n.defaultLocale = "ru_RU.UTF-8";
}
