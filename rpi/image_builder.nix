{
  pkgs,
  rpiSys,
  inputs,
}:

with rpiSys.pkgs;
let 
  b = rpiSys.config.system.build.toplevel;
  c = pkgs.buildPackages.closureInfo { rootPaths = b; };
  size = "476G"; # (476GiB = 512GB)
  rootMountPoint = "/mnt";
  diskoScript = import ("${inputs.disko}/cli.nix") {
    inherit pkgs rootMountPoint;
    mode = "format,mount";
    diskoFile = "${./configuration/disko.nix}";
  };
  diskoUnmount = import ("${inputs.disko}/cli.nix") {
    inherit pkgs rootMountPoint;
    mode = "unmount";
    diskoFile = "${./configuration/disko.nix}";
  };
  dev = "/dev/nbd0";
  subs = lib.mapAttrsToList (attr: val: {uuid = val.uuid; index = val._index;}) rpiSys.config.disko.devices.disk.main.content.partitions;
  subsscript = file: lib.concatStrings (map (item: ''
    sed -i "s@/dev/disk/by-partuuid/${item.uuid}@${dev}p${toString item.index}@" ${file};
  '') subs);
in
(vmTools.override {
  rootModules = [
    "virtio_pci"
    "virtio_mmio"
    "virtio_blk"
    "virtio_balloon"
    "virtio_rng"
    "ext4"
    "virtiofs"
    "crc32c_generic"
    "nbd"
    "vfat"
    "nls_cp437"
    "nls_iso8859-1"
  ];
}).runInLinuxVM (
  runCommand "rpi-image-with-bootloader"
    {
      enableParallelBuildingByDefault = true;
      memSize = "18000";

      # preVM = vmTools.createEmptyImage {
      #   size = 32786;
      #   fullName = "vm-build-space";
      # };

      nativeBuildInputs = [
        nixos-enter
        nixos-install
        util-linux
        zstd
        nix
        qemu
        kmod
        gnused
        nbd
        dosfstools
      ];

      # postVM = ''
      # '';
    }
    ''
      echo Importing DB...
      export NIX_STATE_DIR=$TMPDIR/state
      nix-store --load-db < ${c}/registration
      chmod 755 $TMPDIR

      echo Creating Image...
      mkdir -p $out
      export IMAGE=$out/rpi.qcow2
      qemu-img create -f qcow2 $IMAGE ${size}
      qemu-nbd --connect=/dev/nbd0 $IMAGE --sock $(realpath ./qemu-sock)

      echo Formatting Image...
      export NIX_PATH="nixpkgs=${inputs.nixpkgs}"
      cp ${diskoScript}/bin/* ./format
      ${subsscript "./format"}
      ./format --yes-wipe-all-disks

      echo Installing...
      nixos-install --root ${rootMountPoint} --no-root-password --system ${b} --no-channel-copy --substituters ""
      cp ${diskoUnmount}/bin/* ./unmount
      ${subsscript "./unmount"}
      ./unmount --yes-wipe-all-disks

      echo Unmounting...
      qemu-nbd -d /dev/nbd0
    ''
)
