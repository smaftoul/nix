{ ... }: {
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];

  boot.cleanTmpDir = true;
  zramSwap.enable = true;
  networking.hostName = "satelite";
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  time.timeZone = "Europe/Paris";

  users.users.root.openssh.authorizedKeys.keys = [ ./ssh_key.pub ];

  users.users.smaftoul = {
    openssh.authorizedKeys.keys = [ ./ssh_key.pub ];
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = "/etc/profiles/per-user/smaftoul/bin/zsh";
  };

  security.sudo.wheelNeedsPassword = false;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.smaftoul = import ./home.nix;

  environment.shells = [ "/etc/profiles/per-user/smaftoul/bin/zsh" ];
  environment.pathsToLink = [ "/share/zsh" ];
}
