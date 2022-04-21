{ pkgs, ... }:

{
 programs = {
   home-manager.enable = true;

   zsh = {
     enable = true;
     enableAutosuggestions = true;
     enableSyntaxHighlighting = true;
     enableVteIntegration = true;
     initExtra = ''export PATH="$PATH''${PATH:+:}$HOME/.local/bin"'';
   };

   direnv.enable = true;
   starship.enable = true;

   fzf = {
     enable = true;
     enableZshIntegration = true;
   };

   git.enable = true;

 };

 home = {
   packages = [
     pkgs.nixpkgs-fmt
     pkgs.unzip
     pkgs.tfswitch
     pkgs.ripgrep
     pkgs.oci-cli
   ];

   file.".tfswitch.toml".text = ''bin = "$HOME/.local/bin/terraform"'';

   # TODO: doesn't work, when fixed cleanup programs.zsh.initExtra
   sessionPath = [ "$HOME/.local/bin" ];
  };

}
