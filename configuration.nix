# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ 
        ./hardware-configuration.nix
    ];


  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";

  networking.networkmanager.enable = true;

  services.sshd.enable = true;
  security.sudo.wheelNeedsPassword = false;  
  programs.zsh.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  time.timeZone = "Europe/Warsaw";

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


  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;


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
     spice-vdagent
     zoxide

     wl-clipboard
   ];
  system.stateVersion = "25.11"; 

}

