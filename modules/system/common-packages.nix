{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Системное
    git
    vim
    wget
    curl
    pciutils
    usbutils
    
    # Мониторинг (то, что мы хотели)
    btop
    powertop
    amdgpu_top
    libva-utils  # для vainfo
    fastfetch
  ];

  # Включаем экспериментальные фичи везде
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
