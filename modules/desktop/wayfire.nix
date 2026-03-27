{ config, pkgs, userName, ... }:

{
  # 1. Системная активация Wayfire
  programs.wayfire = {
    enable = true;
    plugins = with pkgs.wayfirePlugins; [
      wcm
      wf-shell
      wayfire-plugins-extra
    ];
  };

  # 2. Настройка Home Manager для конкретного пользователя
  home-manager.users."${userName}" = {
    home.username = userName;
    home.stateVersion = "24.11";

    # Подтягиваем конфиг из соседнего файла
    home.file.".config/wayfire.ini".source = ./wayfire/config.ini;

    # Добавляем базовые сервисы для комфорта
    services.mako.enable = true;
  };

  # 3. Системные пакеты, чтобы не оказаться в пустой коробке
  environment.systemPackages = with pkgs; [
    foot    # Терминал
    fuzzel  # Лаунчер (Super+D)
    grim    # Скриншоты
    slurp   # Выбор области
  ];

  # Порталы для корректной работы GUI
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };
}
