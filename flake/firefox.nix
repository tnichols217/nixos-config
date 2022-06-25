{
  imports = {
  };

  outputs = { self, ... }: {
    nixosModules = {
      firefoxAddons = import ./firefox/addons.nix;
    };
  };
}