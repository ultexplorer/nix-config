{
  description = "My Managed NixOS Flake";

  inputs = {
    # Переключаемся на стабильную ветку, где нет ошибок в пакетах
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    # Home Manager должен соответствовать версии системы
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      userName = "igor";
      system = "x86_64-linux";
    in {
      nixosConfigurations.t14 = nixpkgs.lib.nixosSystem {
        inherit system;
        # Передаем переменные внутрь модулей
        specialArgs = { inherit inputs userName; };
        modules = [
           { nixpkgs.config.allowUnfree = true; }
          ./hosts/t14/configuration.nix
          # Подключаем Home Manager как модуль системы
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit userName; };
            # Импортируем настройки пользователя
            home-manager.users.${userName} = import ./modules/home/home.nix;
          }
        ];
      };
    };
}

