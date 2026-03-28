{
  description = "My Managed NixOS Flake with Disko Support";

  inputs = {
    # Стабильная ветка системы
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    # Добавляем Disko для автоматической разметки
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, disko, ... }@inputs:
    let
      userName = "igor";
      system = "x86_64-linux";
    in {
      nixosConfigurations.t14 = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs userName; };
        modules = [
          # 1. Модуль Disko
          disko.nixosModules.disko
          # 2. Твой конфиг разметки (создай этот файл рядом)
          ./hosts/t14/disko-config.nix
          
          { nixpkgs.config.allowUnfree = true; }
          
          ./hosts/t14/configuration.nix
          
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit userName; };
            home-manager.users.${userName} = import ./modules/home/home.nix;
          }
        ];
      };
    };
}
