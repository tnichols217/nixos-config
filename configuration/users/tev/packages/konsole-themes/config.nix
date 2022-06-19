{ pkgs ? import <nixpkgs> {} }:
let 
background = "a";
in
{
  "/konsole/KonsoleTheme.profile"= {
    "Appearance"= {
      "items"= {
        "ColorScheme"= "KonsoleColors";
      };
    };
    "General"= {
      "items"= {
        "Name"= "KonsoleTheme";
        "Parent"= "FALLBACK/";
      };
    };
    "Scrolling"= {
      "items"= {
        "HistoryMode"= "2";
      };
    };
  };
}