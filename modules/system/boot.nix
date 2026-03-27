{ pkgs, ... }:

{
  # Используем самое свежее ядро для всех систем
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Настройки загрузчика (если у тебя systemd-boot)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Общие параметры ядра (например, тихая загрузка)
  boot.kernelParams = [ "quiet" "splash" ];
}
