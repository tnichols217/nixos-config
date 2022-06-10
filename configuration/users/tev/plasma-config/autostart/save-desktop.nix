
{ app, name, username }:
{
  home-manager.users.${username} = {
    xdg = {
      configFile = {
        "autostart/${name}.desktop" = {
          recursive = true;
          source = "${app}/share/applications/${name}.desktop";
        };
      };
    };
  };
}