{ config, pkgs, host-name, lib, ... }:
{
  imports =
    [
      # ./userspace/plasma.nix
      ./userspace/hyprland.nix
      ./userspace/greetd.nix
    ];
  services = {
    libinput.enable = true;
    xserver = {
      enable = true;
      wacom.enable = true;
      videoDrivers = (if host-name == "ASUS" then [
        "nvidia"
      ] else [
        "amdgpu"
        # "virtualbox"
        "hyperv_fb"
        "fbdev"
        "modesetting"
      ]) ++ [];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      nssmdns6 = true;
      openFirewall = true;
    };
    # printing = {
    #   enable = true;
    #   drivers = [ pkgs.gutenprintBin pkgs.hplipWithPlugin pkgs.brgenml1lpr pkgs.brgenml1cupswrapper pkgs.cnijfilter2 ];
    # };
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      font-awesome
    ] ++ lib.lists.filter lib.isDerivation (builtins.attrValues nerd-fonts);
    enableDefaultPackages = true;
  };
  programs.dconf.enable = true;
} 