# Trevor's NixOS Config files

First Partition two disks:
1. One for Boot in format FAT with label NIXBOOT `mkfs.fat -F 32 DISK; fatlabel DISK NIXBOOT`
2. One for Nix in format ext4 with label NIXROOT `mkfs.ext4 DISK -L NIXROOT`

Install with: `curl https://raw.githubusercontent.com/tnichols217/nixos-config/main/install | sudo sh`