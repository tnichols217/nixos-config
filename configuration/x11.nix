{ config, pkgs, host-name, ... }:
{
  imports =
    [
      ./x11/plasma5.nix
      # ./x11/hyprland.nix
    ];
  services = {
    xserver = {
      enable = true;
      libinput.enable = true;
      wacom.enable = true;
      videoDrivers = [
        # "amdgpu"
        "nvidia"
        # "virtualbox"
        # "hyperv_fb"
        # "fbdev"
        # "modesetting"
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