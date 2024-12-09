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
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  } // (if host-name == "ROG" then {
    extraPackages = with pkgs; [
      # rocm-opencl-icd
      # rocm-opencl-runtime
    ];
  } else {});

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
    ] ++ builtins.attrValues nerd-fonts;
    enableDefaultPackages = true;
  };
  programs.dconf.enable = true;
} 