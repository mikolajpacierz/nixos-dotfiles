{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../configuration.nix
  ];

  
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.mikolaj = ../../home.nix;
    };
  
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  systemd.user.services.spice-vdagent-wayland-fix = {
    description = "Reliably start spice-vdagent for Wayland";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.spice-vdagent}/bin/spice-vdagent -x";
      Restart = "always";
      RestartSec = "2";
    };
  };

  networking.hostName = "nixos";
}
