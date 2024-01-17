{ pkgs ? import <nixpkgs> {} }:
{
  "/share/konsole/KonsoleTheme.profile"= {
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
        "ScrollBarPositition"= "2";
      };
    };
  };
  "/share/konsole/KonsoleColors.colorscheme"= {
    "Background"= {
      "items"= {
        "Color"= "60,0,0";
        "RandomHueRange"= "360";
        "RandomSaturationRange"= "100";
      };
    };
    "BackgroundFaint"= {
      "items"= {
        "Color"= "60,0,0";
        "RandomHueRange"= "360";
        "RandomSaturationRange"= "100";
      };
    };
    "BackgroundIntense"= {
      "items"= {
        "Color"= "60,0,0";
        "RandomHueRange"= "360";
        "RandomSaturationRange"= "100";
      };
    };
    "Color0"= {
      "items"= {
        "Color"= "0,0,0";
      };
    };
    "Color0Faint"= {
      "items"= {
        "Color"= "24,24,24";
      };
    };
    "Color0Intense"= {
      "items"= {
        "Color"= "104,104,104";
      };
    };
    "Color1"= {
      "items"= {
        "Color"= "250,75,75";
      };
    };
    "Color1Faint"= {
      "items"= {
        "Color"= "101,25,25";
      };
    };
    "Color1Intense"= {
      "items"= {
        "Color"= "255,84,84";
      };
    };
    "Color2"= {
      "items"= {
        "Color"= "24,178,24";
      };
    };
    "Color2Faint"= {
      "items"= {
        "Color"= "0,101,0";
      };
    };
    "Color2Intense"= {
      "items"= {
        "Color"= "84,255,84";
      };
    };
    "Color3"= {
      "items"= {
        "Color"= "178,104,24";
      };
    };
    "Color3Faint"= {
      "items"= {
        "Color"= "101,74,0";
      };
    };
    "Color3Intense"= {
      "items"= {
        "Color"= "255,255,84";
      };
    };
    "Color4"= {
      "items"= {
        "Color"= "24,24,178";
      };
    };
    "Color4Faint"= {
      "items"= {
        "Color"= "0,0,101";
      };
    };
    "Color4Intense"= {
      "items"= {
        "Color"= "84,84,255";
      };
    };
    "Color5"= {
      "items"= {
        "Color"= "225,30,225";
      };
    };
    "Color5Faint"= {
      "items"= {
        "Color"= "95,5,95";
      };
    };
    "Color5Intense"= {
      "items"= {
        "Color"= "255,84,255";
      };
    };
    "Color6"= {
      "items"= {
        "Color"= "24,178,178";
      };
    };
    "Color6Faint"= {
      "items"= {
        "Color"= "0,101,101";
      };
    };
    "Color6Intense"= {
      "items"= {
        "Color"= "84,255,255";
      };
    };
    "Color7"= {
      "items"= {
        "Color"= "178,178,178";
      };
    };
    "Color7Faint"= {
      "items"= {
        "Color"= "101,101,101";
      };
    };
    "Color7Intense"= {
      "items"= {
        "Color"= "255,255,255";
      };
    };
    "Foreground"= {
      "items"= {
        "Color"= "99,240,99";
        "RandomHueRange"= "360";
        "RandomSaturationRange"= "100";
      };
    };
    "ForegroundFaint"= {
      "items"= {
        "Color"= "122,200,122";
        "RandomHueRange"= "360";
        "RandomSaturationRange"= "100";
      };
    };
    "ForegroundIntense"= {
      "items"= {
        "Color"= "52,240,52";
        "RandomHueRange"= "360";
        "RandomSaturationRange"= "100";
      };
    };
    "General"= {
      "items"= {
        "Anchor"= "0.5,0.5";
        "Blur"= "true";
        "ColorRandomization"= "true";
        "Description"= "KonsoleColors";
        "FillStyle"= "Tile";
        "Opacity"= "0.7";
        "Wallpaper"= "";
        "WallpaperOpacity"= "1";
      };
    };
  };
}