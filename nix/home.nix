{
  config,
  pkgs,
  ...
}: let
  dotfiles = "${config.home.homeDirectory}/nix/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    nvim = "nvim";
    kitty = "kitty";
    rofi = "rofi";
  };
in {
  home.username = "floki";
  home.homeDirectory = "/home/floki";
  home.stateVersion = "26.11";
  # programs.bash = {
  #  enable = true;
  #  shellAliases = {
  #    btw = "echo i use nixos, btw";
  #    c = "clear";
  #    nrs = "sudo nixos-rebuild switch --flake .";
  #  };
  #  initExtra = ''
  #    export PS1="\[\e[38;5;75m\]\u@\h \[\e[38;5;113m\]\w \[\e[38;5;189m\]\$ \[\e[0m\]"
  #  '';
  #};

  xdg.configFile =
    builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  home.packages = with pkgs; [
    ripgrep
    nodejs
    nixpkgs-fmt
  ];
}
