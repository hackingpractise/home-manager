{
  pkgs,
  rustToolchain,
  ...
}: {
  home.username = "raph";
  home.homeDirectory = "/home/raph";
  home.stateVersion = "25.11";

  nixpkgs.config.allowUnfree = true;

  home.packages = [
    rustToolchain
    pkgs.bacon
    pkgs.chafa
    pkgs.dust
    pkgs.helix
    pkgs.eza
    pkgs.fh
    pkgs.go
    pkgs.gotop
    pkgs.htop
    pkgs.hyperfine
    pkgs.lolcat
    pkgs.ncspot
    pkgs.neofetch
    pkgs.pass
    pkgs.peazip
    pkgs.presenterm
    pkgs.ripgrep-all
    pkgs.rusty-man
    pkgs.sccache
    pkgs.sd
    pkgs.sl
    pkgs.speedtest-rs
    pkgs.unzip
    pkgs.uutils-coreutils
    pkgs.viu
    pkgs.wiki-tui
    pkgs.wl-gammarelay-rs
    pkgs.xfce.thunar
    pkgs.xh
    pkgs.yazi
    pkgs.zig
    pkgs.zip
    pkgs.zls

    # VCS [Version Control System]
    pkgs.jujutsu

    # CLI tools
    # pkgs.curlie
    pkgs.jq
    # pkgs.posting

    # Nixd lsp
    pkgs.alejandra
    pkgs.nixd

    # Unfree software
    pkgs.obsidian

    # Lib
    pkgs.zeromq
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # configuration for librewolf
  programs.librewolf = {
    package = pkgs.librewolf-bin;
    enable = true;
    languagePacks = [
      "en-GB"
      "ja"
    ];
  };

  # Configuration for nh
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 2d --keep 4";
    osFlake = "/home/raph/nixos";
    homeFlake = "/home/raph/nix";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
