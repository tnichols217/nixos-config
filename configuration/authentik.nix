{ ... }:
{
  services = {
    authentik = {
      enable = true;
      environmentFile = "/run/secrets/authentik/authentik-env";
      settings = {
        # email = {
        #   host = "smtp.cwrunix.com";
        #   port = 587;
        #   username = "authentik@cwrunix.com";
        #   use_tls = true;
        #   use_ssl = false;
        #   from = "authentik@cwrunix.com";
        # };
        disable_startup_analytics = true;
        disable_update_check = true;
        error_reporting__enabled = false;
        avatars = "gravatar,initials";
      };
    };
    authentik-ldap = {
      enable = true;
      environmentFile = "/run/secrets/authentik/authentik-env";
    };
  };
}