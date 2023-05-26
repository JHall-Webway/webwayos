{ config, pkgs, ... }:

{
  home = {
    stateVersion = "22.11";
    username = "jhall";
    homeDirectory = "/home/jhall";
    packages = with pkgs; [
      alacritty
      lazygit
      dmenu
      nodejs
      python3Full
      rustup
      gcc
      tree-sitter
      rnix-lsp
      lua-language-server
      neofetch
      wally-cli
    ];
    shellAliases = {
      c = "clear";
    };
  };
  xsession = { enable = true;
    windowManager.awesome = { enable = true; };
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
	(nvim-treesitter.withPlugins (p: [ p.c p.javascript p.lua p.nix ]))
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
