{ pkgs, ... }:

{
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # fbcon=nodefer защищает крупный шрифт от сброса при загрузке видеодрайвера AMD
  boot.kernelParams = [ "quiet" "splash" "loglevel=3" "fbcon=nodefer" ];

  # Настройки консоли (TTY)
  console = {
    enable = true;
    font = "ter-v32n"; 
    packages = [ pkgs.terminus_font ];
    earlySetup = true; # Шрифт появится сразу при вводе пароля/загрузке
    keyMap = "us"; 
  };

  # Гарантируем наличие шрифта в системе
  i18n.consolePackages = [ pkgs.terminus_font ];

  # Устанавливаем системный язык на английский (США)
  i18n.defaultLocale = "en_US.UTF-8";

  # Если всё же нужны русские форматы (даты, валюта), можно добавить это:
  # i18n.extraLocaleSettings = {
  #   LC_TIME = "ru_RU.UTF-8";
  #   LC_MONETARY = "ru_RU.UTF-8";
  # };
}

