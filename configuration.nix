# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  ...
}: {
  # BOOTLOADER

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";

  # NIX

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # LOCALES

  time.timeZone = "Europe/Warsaw";

  # USERS

  users.users.mikolaj = {
    isNormalUser = true;
    home = "/home/mikolaj";
    description = "Mikolaj";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMZ0NUiy5Hj4TAncdIqPIKIlMptX0JC4wrvn6NnVGxG4 mikolaj@pc"
    ];
  };

  security.sudo.wheelNeedsPassword = false;

  # NETWORKING

  networking.networkmanager.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # AUDIO

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  security.rtkit.enable = true;

  # GRAPHICS

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    epiphany        
    geary           
    evince        
    totem           
    yelp               
    gnome-tour         
    gnome-photos
    gnome-music
    gnome-weather
    gnome-contacts
    gnome-characters
    
    atomix
    hitori
    iagno
    tali
  ];

  # SERVICES

  programs.zsh.enable = true;

  services.printing.enable = true;

  services.libinput.enable = true;

  # FONTS

  fonts.packages = with pkgs; [
    meslo-lgs-nf
  ];

  # PACKAGES
  environment.systemPackages = with pkgs; [
    vim
    neovim
    git
    rustc
    cargo
    gcc
    fastfetch
    curl
    wget
    zoxide
    fzf
    bat
    zsh-you-should-use
    zsh-fzf-tab
    zsh-autopair
    zsh-powerlevel10k
    ghostty
    vlc
    wl-clipboard
    
    jetbrains.idea
    jetbrains.rust-rover
    brave
    steam
  ];

  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  system.stateVersion = "25.11";
}
