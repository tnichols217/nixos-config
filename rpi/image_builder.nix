{
  pkgs,
  rpiSys,
}:

with rpiSys.pkgs;
vmTools.runInLinuxVM (
  runCommand "rpi-image-with-bootloader"
    {
      enableParallelBuildingByDefault = true;
      memSize = "8000";

      preVM = vmTools.createEmptyImage {
        size = 32768;
        fullName = "vm-image";
      };

      nativeBuildInputs = [
        nixos-enter
        nixos-install
        util-linux
        zstd
      ];

      postVM = ''
        mkdir -p $out
        ${gnutar}/bin/tar --zstd -cvf $out/img.tar.zst ./rootfs
      '';
    }
    ''
      nixos-install --root ./rootfs --no-root-password --system ${rpiSys.config.system.build.toplevel} --no-channel-copy --substituters ""
    ''
)
