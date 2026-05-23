{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../configuration.nix
  ];

  {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.mikolaj = ../../home.nix;
  };

  networking.hostName = "thinkpad";
}
