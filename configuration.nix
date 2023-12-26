# configuration in this file is shared by all hosts

{ pkgs, pkgs-unstable, inputs, ... }:
let inherit (inputs) self;
in {
  # Enable NetworkManager for wireless networking,
  # You can configure networking with "nmtui" command.
  networking.useDHCP = true;
  networking.networkmanager.enable = false;

  users.users = {
    root = {
      initialHashedPassword = "$6$57BFBDSN659fkxQd$x9eVCknZbKd./8rrUyobvtyruVx51y7CSBRodDn4tDlltJ3lQVKQkIrzQlYX9R5PsfVBbdQGNOB19.3D.BCi.1";
      openssh.authorizedKeys.keys = [ ];
    };
    jtdoepke = {
      isNormalUser = true;
      home = "/home/jtdoepke";
      description = "Jaye Doepke";
      group = "jtdoepke";
      uid = 1000;
      initialHashedPassword = "$6$OU8N2t0gDaW6eYCp$pBsUQm3zz5szeskXlLzn0ssjaMm6VGg.Vzka1fTq26jPr5wK39tLrcDNTNt6U1SM6/urOtf68J6D4WhKrFWym1";
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICkQZ8V2cVdXdM3q4bSb9fgvEaCpqJYBWSwy6FjjqaJV" "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINjJhKbiyNstn9bsvldrWsYBWXgpva0hCoxj9pYUUBpL" ];
    };
  };
  users.groups = {
    jtdoepke = {
      gid = 1000;
    };
  };

  ## enable GNOME desktop.
  ## You need to configure a normal, non-root user.
  # services.xserver = {
  #  enable = true;
  #  desktopManager.gnome.enable = true;
  #  displayManager.gdm.enable = true;
  # };

  ## enable ZFS auto snapshot on datasets
  ## You need to set the auto snapshot property to "true"
  ## on datasets for this to work, such as
  # zfs set com.sun:auto-snapshot=true rpool/nixos/home
  services.zfs = {
    autoSnapshot = {
      enable = false;
      flags = "-k -p --utc";
      monthly = 48;
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  services.openssh = {
    enable = true;
    settings = { PasswordAuthentication = false; };
  };

  boot.zfs.forceImportRoot = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.initrd.systemd.enable = true;

  programs.git.enable = true;

  security = {
    doas.enable = true;
    sudo.enable = false;
  };

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      mg # emacs-like editor
      jq # other programs
    ;
    # By default, the system will only use packages from the
    # stable channel. i.e.
    # inherit (pkg) my-favorite-stable-package;
    # You can selectively install packages
    # from the unstable channel. Such as
    # inherit (pkgs-unstable) my-favorite-unstable-package;
    # You can also add more
    # channels to pin package version.
  };

  # Safety mechanism: refuse to build unless everything is
  # tracked by git
  system.configurationRevision = if (self ? rev) then
    self.rev
  else
    throw "refuse to build: git tree is dirty";

  system.stateVersion = "23.11";

  # let nix commands follow system nixpkgs revision
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  # you can then test any package in a nix shell, such as
  # $ nix shell nixpkgs#neovim
}
