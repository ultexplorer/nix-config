{ config, pkgs, ... }:

{
  # ===== ГРАФИКА AMD (Ryzen 5000 / Cezanne) =====
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva
      libva-utils
      libvdpau-va-gl
      vaapiVdpau
    ];
  };

  # Ранняя загрузка драйвера GPU (важно для плавности)
  boot.initrd.kernelModules = [ "amdgpu" ];

  # ===== ФИКСЫ ДЛЯ СТАБИЛЬНОСТИ RYZEN =====
  boot.kernelParams = [
    "amdgpu.sg_display=0"    # Лечит фризы графики на Cezanne
    "processor.max_cstate=1" # Ограничиваем глубокий сон ядер (защита от ребутов)
    "pcie_aspm=off"           # ВЫКЛЮЧАЕМ управление питанием шины (главный подозреваемый)
  ];

  # Микрокод CPU - критично для стабильности
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
  hardware.enableRedistributableFirmware = true;

  # Оптимизация для SSD (важно для NVMe на ThinkPad)
  services.fstrim.enable = true;
}
