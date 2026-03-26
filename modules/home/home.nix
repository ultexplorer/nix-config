{ config, pkgs, userName, lib, ... }:

{
  home.username = userName;
  home.homeDirectory = lib.mkForce "/home/${userName}";
  home.stateVersion = "24.11";

  # Тот самый блок, про который ты спрашивал:
  # home.file.".xinitrc".text = ''
  # Запуск самой оболочки Xfce
  #exec dbus-launch --exit-with-session startxfce4  '';

  home.file.".xinitrc".text = ''
     exec dbus-run-session startxfce4
  '';


  # Добавляем необходимые пакеты в профиль пользователя
  home.packages = with pkgs; [
#    xorg.xinit  # предоставляет команду startx
    dbus        # нужен для dbus-launch
  ];

  programs.home-manager.enable = true;
}
