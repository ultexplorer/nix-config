{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- БАЗОВЫЙ НАБОР (ОБЩЕЕ) ---
    tree             # <--- ВОТ ОН, РОДНОЙ!
    git
    wget
    curl
    vim              # (или nano/neovim, что ты используешь)
    htop
    fastfetch
    
    # Сюда же можно со временем докинуть браузер или файловый менеджер
  ];
}
