{ persistence ? rec {
  default = "/nix/persist";
  local = "${default}/local";
}, format ? true, ... }:
{
  disko.devices = {
    disk = {
      main = {
        device = if format then "/dev/nbd0" else "/dev/nbd0";
        imageSize = "64G";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "500M";
              label = "PIBOOT";
              uuid = "1138a498-29e9-4564-9604-0b0642e83905";
              _index = 1;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "64G";
              label = "PIROOT";
              uuid = "2138a498-29e9-4564-9604-0b0642e83905";
              _index = 2;
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = if format then "/nix/store" else "/nix/.ro-store";
                mountOptions = if format then [] else [ "ro" ];
              };
            };

            local = {
              size = "16G";
              label = "PILOCAL";
              uuid = "3138a498-29e9-4564-9604-0b0642e83905";
              _index = 3;
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "${persistence.local}";
              };
            };

            data = {
              size = "100%";
              label = "PIDATA";
              uuid = "4138a498-29e9-4564-9604-0b0642e83905";
              _index = 4;
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "${persistence.default}";
              };
            };
          };
        };
      };
    };
  };
  disko.imageBuilder.enableBinfmt = true;
}