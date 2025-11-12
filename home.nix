{pkgs, ...}: {
  home.username = "raph";
  home.homeDirectory = "/home/raph";
  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.nix;
    settings.experimental-features = ["nix-command" "flakes"];
  };
  # environment.
  home.packages = [
    # pkgs.file-roller
    # pkgs.powertop
    pkgs.atuin
    pkgs.bacon
    pkgs.bat
    pkgs.carapace
    pkgs.chafa
    pkgs.dnsmasq
    pkgs.dust
    pkgs.evil-helix
    pkgs.eza
    pkgs.ffmpeg-full
    pkgs.fh
    pkgs.fzf
    pkgs.git-cliff
    pkgs.gitFull
    pkgs.go
    pkgs.gotop
    pkgs.htop
    pkgs.hyperfine
    pkgs.lazygit
    pkgs.lm_sensors
    pkgs.lolcat
    pkgs.ncspot
    pkgs.neofetch
    pkgs.neovim
    pkgs.nh
    pkgs.nodejs
    pkgs.nushell
    pkgs.pass
    pkgs.peazip
    pkgs.presenterm
    pkgs.procs
    pkgs.qemu
    pkgs.ripgrep
    pkgs.rustup
    pkgs.rusty-man
    pkgs.sccache
    pkgs.sd
    pkgs.sl
    pkgs.speedtest-rs
    pkgs.starship
    pkgs.stow
    pkgs.tlrc
    pkgs.unzip
    pkgs.uutils-coreutils
    pkgs.viu
    pkgs.vlc
    pkgs.wget
    pkgs.wiki-tui
    pkgs.wl-gammarelay-rs
    pkgs.xfce.thunar
    pkgs.xh
    pkgs.yazi
    pkgs.zig
    pkgs.zip
    pkgs.zls
    pkgs.zoxide

    # CLI tools
    pkgs.curlie
    pkgs.jq
    pkgs.posting

    # Nixd lsp
    pkgs.alejandra
    pkgs.nixd
    # Unfree software
    pkgs.obsidian
    pkgs.vscode

    # Lib
    pkgs.zeromq

    # Container Tools
    # pkgs.containerd
    pkgs.docker
    pkgs.docker-compose
    pkgs.docker-gc
    pkgs.docker-init
    pkgs.docker-slim
    pkgs.grype
    pkgs.lazydocker
    pkgs.lazyjournal
    pkgs.lazysql
    pkgs.podlet
    pkgs.podman-compose
    pkgs.podman-desktop
    pkgs.syft
    pkgs.virtiofsd

    # Hacking tools
    pkgs.gobuster
    pkgs.whatweb
    pkgs.nmap
    pkgs.hashcat
    pkgs.john
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    FLAKE = "/home/raph/nix";
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

  # Configured podman
  services.podman = {
    enable = true;

    settings.policy = {
      default = [{type = "insecureAcceptAnything";}];
      transports = {
        docker-daemon = {
          "" = [{type = "insecureAcceptAnything";}];
        };
      };
    };
  };

  # configuration for tmux
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    disableConfirmationPrompt = true;
    keyMode = "vi";
    mouse = true;
    prefix = "C-space";
    sensibleOnTop = true;
    shell = "/usr/bin/fish";
    terminal = "screen-256color";
    secureSocket = true;
    plugins = with pkgs; [
      tmuxPlugins.cpu
      tmuxPlugins.yank
      tmuxPlugins.tmux-fzf
      tmuxPlugins.catppuccin
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
    ];
    extraConfig = ''
      set-option -sa terminal-overrides ",xterm*:Tc"
      set-option -g status-position top
      set -g set-clipboard external
      set -g @catppuccin_flavour 'mocha'
      # Vim style pane selection
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      # Use Alt-arrow keys without prefix key to switch panes
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Shift arrow to switch windows
      bind -n S-Left  previous-window
      bind -n S-Right next-window

      # Shift Alt vim keys to switch windows
      bind -n M-H previous-window
      bind -n M-L next-window
      # keybindings
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
