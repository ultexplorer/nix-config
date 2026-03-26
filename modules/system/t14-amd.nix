{ config, pkgs, ... }:

{
  # ===== ГРАФИКА AMD (Ryzen 5000 / Cezanne) =====
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      mesa.drivers
      libva
      libva-utils
      libvdpau-va-gl
    ];
  };

  # ранняя загрузка драйвера GPU
  boot.initrd.kernelModules = [ "amdgpu" ];

  # ===== ФИКСЫ ДЛЯ RYZEN 5000 =====
  boot.kernelParams = [
    "amdgpu.sg_display=0"
    "acpi_backlight=native"
    "amdgpu.dcdebugmask=0x10"
    "idle=nomwait"
  ];

  # микрокод CPU
  hardware.cpu.amd.updateMicrocode = true;

  # ===== ЗВУК (PipeWire) =====
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # ===== THINKPAD =====
  hardware.acpilight.enable = true;
  hardware.enableAllFirmware = true;
}
