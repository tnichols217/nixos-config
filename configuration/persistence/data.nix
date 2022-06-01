{ config, pkgs, ... }:
{
  environment.persistence."${./data}" = {
    hideMounts = false;
    directories = [
    ];
    files = [
    ];
  };
}