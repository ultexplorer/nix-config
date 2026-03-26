{ config, pkgs, lib, ... }:

let
  users = builtins.attrNames config.users.users or [];
in
{
  # ===== SYSTEM PACKAGES =====
  environment.systemPackages = with pkgs; [
    ffmpeg-full
  ];

  # ===== СРЕДА ДЛЯ VAAPI =====
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "radeonsi";
    MOZ_DISABLE_RDD_SANDBOX = "1";
  };

  # ===== FIREFOX НАСТРОЙКИ ДЛЯ ВСЕХ ПОЛЬЗОВАТЕЛЕЙ =====
  home.file.".mozilla/firefox/user.js".text = lib.concatStringsSep "\n" (map (userName:
    ''
      // Аппаратное декодирование Firefox
      user_pref("media.ffmpeg.vaapi.enabled", true);
      user_pref("media.rdd-ffmpeg.enabled", true);
      user_pref("media.hardware-video-decoding.force-enabled", true);
      user_pref("gfx.webrender.all", true);
    ''
  ) users);
}
