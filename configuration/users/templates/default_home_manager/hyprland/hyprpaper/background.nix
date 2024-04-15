{ host-name }:
"${if host-name == "ASUS" then ./background/choco28bit.png else (
  if host-name == "MSI" then ./background/choco8bit.png else ./background/meatCubes8bit.png
)}"