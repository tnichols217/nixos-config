{ host-name }:
"${if host-name == "ASUS" then ./background/choco2.png else (
  if host-name == "MSI" then ./background/choco.png else ./background/choco.png
)}"