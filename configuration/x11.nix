{ config, pkgs, host-name, ... }:
{
  imports =
    [
      # ./x11/plasma.nix
      ./x11/hyprland.nix
      ./x11/greetd.nix
    ];
  services = {
    libinput.enable = true;
    xserver = {
      enable = true;
      wacom.enable = true;
      videoDrivers = (if host-name == "ASUS" then [] else [
        "amdgpu"
        # "virtualbox"
        "hyperv_fb"
        "fbdev"
        "modesetting"
      ]) ++ [
        "nvidia"
      ];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      nssmdns6 = true;
      openFirewall = true;
    };
    printing = {
      enable = true;
      drivers = [ pkgs.gutenprintBin pkgs.hplipWithPlugin pkgs.brgenml1lpr pkgs.brgenml1cupswrapper pkgs.cnijfilter2 ];
    };
  };
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  fonts = {
    packages = with pkgs; [
      nerdfonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];
    enableDefaultPackages = true;
  };
  programs.dconf.enable = true;
} // (if host-name == "ROG" then {
  hardware.opengl = {
    extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
    ];
  };
} else {})