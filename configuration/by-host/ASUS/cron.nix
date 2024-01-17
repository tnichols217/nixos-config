{ pkgs, attrs, config, ... }:
{
  services.cron = {
    enable = true;
    systemCronJobs = [ ''0,5,10,15,20,25,30,35,40,45,50,55 * * * * root sh /storage/church/config/update.sh'' ];
  };
}