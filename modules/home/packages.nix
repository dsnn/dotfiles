{ pkgs, ... }: {

  home.packages = with pkgs;
    [
      (nerdfonts.override { fonts = [ "FiraCode" "RobotoMono" ]; })
      # bat
      # fzf
      # git
      # htop
      # keychain
      # nawk
      # starship
      # tmux
      # unzip
      # vim
      # wget
      # xclip
      # zsh
      # jq
      # neovim
      # nixfmt
      # nixpkgs-fmt
      # nodePackages.npm
      # nodejs
      # ripgrep
      # fd
      # rnix-lsp
      # sumneko-lua-language-server
      # _1password
      # _1password-gui
      # vault
      # pavucontrol
      # pamixer
      # firefox
      # direnv
    ];

}

# 2023-11-14
# ❯ brew list
# ==> Formulae
# abseil			git-delta		libx11			mpdecimal		python-packaging	tree-sitter
# ansible			gmp			libxau			msgpack			python-pytz		unibilium
# ansible-lint		gnu-sed			libxcb			ncurses			python-setuptools	utf8proc
# awk			htop			libxcursor		neovim			python@3.11		volta
# bat			jpeg-turbo		libxdmcp		oniguruma		python@3.12		wakeonlan
# black			jsoncpp			libxext			openldap		pyyaml			wget
# brotli			keychain		libxfixes		openssl@1.1		readline		xorgproto
# ca-certificates		lazygit			libxi			openssl@3		ripgrep			xz
# cffi			libevent		libxinerama		packer			rtmpdump		yabai
# cksfv			libgit2			libxrandr		pcre			six			yamllint
# coreutils		libidn2			libxrender		pcre2			skhd			z
# curl			libnghttp2		libxv			protobuf		sqlite			zsh
# docker-compose		libssh2			libyaml			pycparser		sstp-client		zsh-autosuggestions
# fd			libtermkey		lsd			pygments		starship		zsh-completions
# freerdp			libunistring		luajit			python-certifi		stow			zsh-syntax-highlighting
# fzf			libusb			luv			python-cryptography	tmux			zstd
# gettext			libuv			lz4			python-lxml		tmuxp
# git			libvterm		mosh			python-markupsafe	tpm

# ==> Casks
# 1password-cli			docker				kitty
# db-browser-for-sqlite		font-fira-code-nerd-font	mos

# dotfiles on  master [!]
# ❯
