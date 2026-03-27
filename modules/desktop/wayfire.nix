{ config, pkgs, ... }:

{
  programs.wayfire = {
    enable = true;
    plugins = with pkgs.wayfirePlugins; [
      wcm
      wf-shell
      wayfire-plugins-extra
    ];
  };

  # Добавляем полезный софт в систему
  environment.systemPackages = with pkgs; [
    # Скриншоты
    grim
    slurp
    # Лаунчер (запуск приложений)
    fuzzel
    # Уведомления
    mako
    libnotify # Чтобы работала команда notify-send
    # Терминал (рекомендую foot для Wayland)
    foot
  ];

  # Включаем порталы (уже обсуждали, но пусть будут здесь)
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  # Прокидываем конфиг из файла, который ты создал
  home-manager.users.ultexplorer = {
    home.file.".config/wayfire.ini".source = ./wayfire/config.ini;
    
    # Можно сразу настроить mako (уведомления), чтобы они были симпатичными
    services.mako = {
      enable = true;
      backgroundColor = "#1e1e2eff"; # Темный фон (Catppuccin)
      textColor = "#cdd6f4ff";
      borderColor = "#89b4faff";
      borderRadius = 5;
      borderSize = 2;
      defaultTimeout = 5000;
    };
  };
}
