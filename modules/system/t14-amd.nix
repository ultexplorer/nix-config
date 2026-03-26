{ config, pkgs, ... }:

{
  # ===== ГРАФИКА AMD (Ryzen 5000 / Cezanne) =====
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    # Чистим extraPackages, оставляем только VA-API для браузера
    extraPackages = with pkgs; [
      libva
      libva-utils
      libvdpau-va-gl
      vaapiVdpau
    ];
  };

  # Ранняя загрузка драйвера GPU (оставляем, это полезно)
  boot.initrd.kernelModules = [ "amdgpu" ];

  # ===== ФИКСЫ ДЛЯ RYZEN (Оптимизировано для ядра 6.x+) =====
  boot.kernelParams = [
    "amdgpu.sg_display=0" # Оставляем, лечит фризы на Cezanne
    "amd_pstate=active"   # ВКЛЮЧАЕМ современное управление питанием
    # "idle=nomwait" -> УДАЛЕНО (причина ребутов)
    # "amdgpu.dcdebugmask" -> УДАЛЕНО (устарело)
  ];

  # Микрокод CPU - критично для безопасности и стабильности
  hardware.cpu.amd.updateMicrocode = true;

  # ===== ЗВУК (PipeWire) =====
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # ===== THINKPAD & FIRMWARE =====
  # hardware.acpilight.enable = true; # Если не пользуешься яркостью через xbacklight, можно убрать
  hardware.enableRedistributableFirmware = true; # Важнее для Wi-Fi и Bluetooth
}
