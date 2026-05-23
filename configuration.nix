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

  # SERVICES

  programs.zsh.enable = true;

  services.printing.enable = true;

  services.libinput.enable = true;

  # LD

  programs.nix-ld.enable = true;
  #  programs.nix-ld.libraries = with pkgs [
  #
  #  ];

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
    zsh-you-should-use
    zsh-fzf-tab
    zsh-autopair
    zsh-powerlevel10k
    ghostty

    vlc
  ];

  system.stateVersion = "25.11";
}
