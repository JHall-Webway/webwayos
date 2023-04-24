{ config, pkgs, ... }:

{
  home = {
    stateVersion = "22.11";
    username = "jhall";
    homeDirectory = "/home/jhall";
    packages = with pkgs; [
      lazygit
      dmenu
      vimb
      nerdfonts
      nodejs
      python3Full
      rustup
      gcc
      tree-sitter
      rnix-lsp
      lua-language-server
      neofetch
      libsForQt5.krdc
    ];
    shellAliases = {
      c = "clear";
      system-switch = "sudo -i nixos-rebuild switch --flake $XDG_CONFIG_HOME#$hostname";
      system-edit = "$EDITOR $XDG_CONFIG_HOME/nixos/configuration.nix";
      home-switch = "home-manager switch --flake $XDG_CONFIG_HOME#$USER@$hostname";
      home-edit = "$EDITOR $XDG_CONFIG_HOME/home-manager/home.nix";
    };
  };
  xdg = { enable = true;
    userDirs = { enable = true;
      createDirectories = true;
    };
  };
  accounts.email.accounts.jhall = {
    primary = true;
    address = "jhalldevelopment@gmail.com";
    thunderbird.enable = true;
  };
  programs = {
    git = { enable = true;
      userName = "James Hall";
      userEmail = "jhall@hallwebway.net";
      package = pkgs.gitAndTools.gitFull;
      diff-so-fancy.enable = true;
      extraConfig = {
        user.user = "jhall";
        init.defaultBranch = "master";
        core.editor = "nvim";
        web.browser = "firefox";
      };
    };
    i3status-rust = { enable = true; 
      bars.jhall = { 
        theme = "gruvbox-dark";
        icons = "gruvbox-dark";
      };
    };
    tmux = { enable = true;
      plugins = with pkgs.tmuxPlugins; [
        gruvbox
      ];
    };
    fish = { enable = true;
      interactiveShellInit = ''
        set fish_greeting
      '';
    };
    nushell = { enable = true;
      
    };
    zoxide = { enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };
    fzf = { enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      colors = { 
        fg = "#ebdbb2"; bg = "#282828"; hl = "#fabd2f";
	"fg+" = "#ebdbb2"; "bg+" = "#3c3836"; "hl+" = "#fabd2f";
	info = "#83a598"; prompt = "#bdae93"; spinner = "#fabd2f";
	pointer = "#83a598"; marker = "#fe8019"; header = "#665c54";
      };
    };
    starship = { enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };
    exa = { enable = true;
      enableAliases = true;
      git = true;
      icons = true;
    };
    neovim = { enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      withPython3 = true;
      plugins = with pkgs.vimPlugins; [
        gruvbox
	vim-devicons
	nvim-web-devicons
        lualine-nvim
        lualine-lsp-progress
	nvim-treesitter.withAllGrammars
	vim-nix
        nvim-lspconfig
        lspkind-nvim
        lsp_lines-nvim
        nvim-cmp
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        cmp-cmdline
        cmp-vsnip
        vim-vsnip
        vim-fugitive
      ];
    };
    firefox = { enable = true;

    };
    home-manager.enable = true;
  };
  services = {
    gpg-agent = { enable = true;
      enableFishIntegration = true;
      enableSshSupport = true;
    };
  };
}
