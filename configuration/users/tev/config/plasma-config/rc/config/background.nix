{ host-name }:
"$(if host-name == "ASUS" then ./background/Anime-Street-Night.png else (
  if host-name == "MSI" then ./background/Anime-Street-Evening.png else ./background/Anime-Street-Day.png
))"