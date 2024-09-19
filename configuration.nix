# Edit this configuration file to define what should be installed on your system. Help is available in the
# configuration.nix(5) man page, on https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{ imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true; boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable network manager applet
  programs.nm-applet.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Algiers";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";

  i18n.extraLocaleSettings = { LC_ADDRESS = "fr_FR.UTF-8"; LC_IDENTIFICATION = "fr_FR.UTF-8"; LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8"; LC_NAME = "fr_FR.UTF-8"; LC_NUMERIC = "fr_FR.UTF-8"; LC_PAPER = "fr_FR.UTF-8"; LC_TELEPHONE =
    "fr_FR.UTF-8"; LC_TIME = "fr_FR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the LXQT Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.desktopManager.lxqt.enable = true;

  # Enable dwm
  services.xserver.windowManager.dwm.package = pkgs.dwm.overrideAttrs {
    src = /home/redha/wrk/repo/dwm;
  };
  services.xserver.windowManager.dwm.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = { layout = "fr"; variant = "bepo_latin9";
  };

  # Configure console keymap
  console.keyMap = "fr-bepo";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  # Support pulseaudio in all applications
  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.extraConfig = "load-module module-combine-sink";

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # try out
  # hardware.opengl.package = unstable.legacyPackages.x86_64-linux.mesa.drivers;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.redha = {
    isNormalUser = true;
    description = "redha";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
  dunst
  xclip
  rofi
  dmenu
  tmux
  git
  vim
  htop
  wget
  curl
  nnn
  w3m
  ];

  # List packages installed in system profile. To search, run: $ nix search wget environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default. wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are started in user sessions. programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true; enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon. services.openssh.enable = true;

  # Open ports in the firewall. networking.firewall.allowedTCPPorts = [ ... ]; networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether. networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system (/run/current-system/configuration.nix). This is
  # useful in case you accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine, and is used to maintain
  # compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason, even if you've upgraded your system
  # to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from, so changing it will NOT upgrade your
  # system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is out of date, out of support, or
  # vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration, and
  # migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  # .
  system.stateVersion = "24.05"; # Did you read the comment?

}
