{ config, pkgs, ... }:

{
  # --- Ядро и параметры (Ryzen 5000 + NTSync + SteamOS 3.8 fixes) ---
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "amd_pstate=active"
      "ntsync.enabled=1"
      "zswap.enabled=1"
      "zswap.compressor=lz4"
      "zswap.max_pool_percent=25"
      "preempt=full"
      "threadirqs"
    ];

    kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.vfs_cache_pressure" = 50;
      "vm.max_map_count" = 2147483642;
      "kernel.sched_autogroup_enabled" = 1;
    };
  };

  # --- Подкачка (Swap) для работы Zswap ---
  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 8192;
  } ];

  # --- Графика и OpenCL для Photoshop ---
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      amdvlk
    ];
  };

  # --- Низкая задержка звука и планировщик диска ---
  services.udev.extraRules = ''
    ACTION=="add|change", KERNEL=="nvme*", ATTR{queue/scheduler}="kyber"
    ACTION=="add", SUBSYSTEM=="leds", KERNEL=="platform::micmute", ATTR{brightness}="0"
  '';

  services.pipewire.extraConfig.pipewire."92-low-latency" = {
    "context.properties" = {
      "default.clock.rate" = 48000;
      "default.clock.quantum" = 128;
    };
  };
}
