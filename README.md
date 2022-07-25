# Trevor's NixOS Config files

First Partition disks:
1. One for Boot in format FAT with label NIXBOOT `mkfs.fat -F 32 DISK; fatlabel DISK NIXBOOT` (512MB)
2. One for Nix in format ext4 with label NIXROOT `mkfs.ext4 DISK -L NIXROOT` (64 - 128GB)
3. One for Persistence in format ext4 with label NIXPERSIST `mkfs.ext4 DISK -L NIXPERSIST` (6 - 32GB)
4. One for swap in format linux-swap with label NIXSWAP `mkswap DISK -L NIXSWAP` (8 - 16GB)
5. One for Userdata in format ext4 with label NIXDATA `mkfs.ext4 DISK -L NIXDATA`(64 - 128GB)
6. One for Large, non-important data in format ext4 with label NIXBUCKET `mkfs.ext4 DISK -L NIXBUCKET` (32 - 128GB)

Install with: `curl https://raw.githubusercontent.com/tnichols217/nixos-config/main/install | sudo sh -s `_modulename_

Update packages with: `nix-shell -p nixFlakes --run "nix --extra-experimental-features nix-command --extra-experimental-features flakes flake update"`