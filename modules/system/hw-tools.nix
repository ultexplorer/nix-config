{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Инструменты для любого железа (универсальные)
    btop
    powertop
    lm_sensors
    pciutils
    usbutils
    dmidecode
    
    # Инструменты для графики (AMD/Vulkan)
    amdgpu_top
    glxinfo
    vulkan-tools

    ######################################
    cpupower-gui
    winetricks
    protonup-qt
    clinfo
    glxinfo
  ];
}
