{ config, pkgs, persistence, ... }:
{
  environment.persistence."${persistence.data}" = {
    hideMounts = false;
    directories = [
      "/root"
    ];
  };
}