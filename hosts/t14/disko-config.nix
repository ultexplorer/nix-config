{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        # Для ThinkPad T14 это стандартный путь NVMe
        device = "/dev/nvme0n1"; 
        content = {
          type = "gpt";
          partitions = {
            # 1. Загрузочный раздел (EFI)
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            # 2. Тот самый физический SWAP-раздел
            swap = {
              size = "8G";
              content = {
                type = "swap";
                discardPolicy = "both"; # Оптимизация для SSD/NVMe
                resumeDevice = true;    # Важно для работы гибернации
              };
            };
            # 3. Основная система (Root)
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
