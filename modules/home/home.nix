{ config, pkgs, userName, lib, ... }:

let
  # ХАРДКОРНЫЙ ВЫБОР (меняем здесь вручную для теста)
  selectedWM = "xfce"; 

  # Словарь команд запуска
  wmCommands = {
    xfce = "exec dbus-run-session startxfce4";
    # Добавим заглушку для теста логики
    test = "exec echo 'Hello NixOS' > /tmp/nix-test.txt"; 
  };
in
{
  home.username = userName;
  home.homeDirectory = lib.mkForce "/home/${userName}";
  home.stateVersion = "24.11";

  # Генерируем .xinitrc
  home.file.".xinitrc".text = ''
    # Настройки для X-сервера
    xsetroot -cursor_name left_ptr &
    
    # Запуск выбранной оболочки из словаря
    ${wmCommands.${selectedWM}}
  '';

  home.packages = with pkgs; [
    dbus
  ];

  programs.home-manager.enable = true;
}
