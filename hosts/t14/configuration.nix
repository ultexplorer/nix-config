{ config, pkgs,lib, userName, ... }:
{
  imports = [
    # ./hardware-configuration.nix  <-- УДАЛЯЕМ ИЛИ КОММЕНТИРУЕМ ЭТУ СТРОКУ! 
    # Теперь разделы диска описываются в disko-config.nix (через flake.nix)

    ../../modules/desktop/ly.nix
    ../../modules/desktop/xfce.nix
    ../../modules/desktop/wayfire.nix
    ../../modules/system/boot.nix
    ../../modules/system/t14-amd.nix
    ../../modules/system/common-packages.nix
    ../../modules/system/hw-tools.nix
  ];
 
  ##########################################################################
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.enableRedistributableFirmware = true;

  ##########################################################################  


  # Порталы для работы приложений (скриншоты, шаринг экрана и т.д.)
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*"; # Чтобы портал понимал, какой бэкенд использовать
  };

  # Настройка пользователя
  users.users.${userName} = {
    isNormalUser = true;
    group = "users";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "input" ]; # Добавил 'input' для Wayfire
  };

  # Загрузчик и сеть
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "t14";
  networking.networkmanager.enable = true;

  # Системные пакеты
  environment.systemPackages = with pkgs; [ 
    firefox 
    git       # Нужен для работы с твоим конфигом
    vim       # Чтобы поправить конфиг, если что-то пойдет не так
    pciutils  # Для lspci
    usbutils  # Для lsusb
  ];

  # Включаем Flakes и новые команды Nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Версия системы (не меняй, если ставил на 24.11)
  system.stateVersion = "24.11";

  # Системные службы
  services.dbus.enable = true;
  security.polkit.enable = true;
  services.xserver.libinput.enable = true;

  # Опционально: Очистка старых поколений автоматически
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
}	
