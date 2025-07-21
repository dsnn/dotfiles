{ inputs, ... }:
{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  programs.zsh.initContent = ''
    function run_nvim() {
      BUFFER="nvim && clear"
      zle accept-line
    }
    zle -N run_nvim
    bindkey "^n" run_nvim
  '';

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    colorschemes = {
      catppuccin = {
        enable = true;
        settings = {
          background = {
            light = "latte";
            dark = "mocha";
          };
          flavour = "mocha";
          no_bold = false;
          no_italic = false;
          no_underline = false;
          transparent_background = true;
          integrations = {
            cmp = true;
            neotree = true;
            treesitter = true;
            telescope.enabled = true;
          };
        };
      };
    };
    globals = {
      mapleader = ",";
      maplocalleader = " ";
    };
    opts = {
      breakindent = true;
      clipboard = {
        register = "unnamedplus";
      };
      cursorline = true;
      hlsearch = false;
      ignorecase = true;
      inccommand = "split";
      list = true;
      listchars.__raw = "{ tab = '» ', trail = '·', nbsp = '␣' }";
      mouse = "a";
      number = true;
      relativenumber = true;
      scrolloff = 10;
      showmode = false;
      signcolumn = "yes";
      smartcase = true;
      splitbelow = true;
      splitright = true;
      tabstop = 2;
      foldenable = false;
      spell = false;
      swapfile = false;
      softtabstop = 2;
      termguicolors = true;
      timeoutlen = 300;
      undofile = false;
      updatetime = 100;
    };

    keymaps = [
      {
        action = ":lua MiniBufremove.delete()<CR>";
        key = "<leader>q";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = ":q<CR>";
        key = "<leader>w";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = ":qa!<CR>";
        key = "<space>qq";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = "<C-^>";
        key = "<leader>.";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = ":wall<CR>";
        key = "<leader>,";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = ":wall<CR>";
        key = "<C-s>";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = ":set hlsearch!<CR>";
        key = "<leader>h";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = ":luafile %<CR>";
        key = "<leader>x";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = ":messages<CR>";
        key = "<leader>m";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = ":noh<CR>";
        key = "<esc>";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = "pgvy";
        key = "p";
        mode = "x";
        options = {
          silent = true;
        };
      }
      {
        action = "<gv";
        key = "<";
        mode = "v";
        options = {
          silent = true;
        };
      }
      {
        action = ">gv";
        key = ">";
        mode = "v";
        options = {
          silent = true;
        };
      }
      {
        action = "<Esc>/\\%V";
        key = "/";
        mode = "x";
        options = {
          silent = true;
        };
      }
      {
        action = "<C-w>h";
        key = "<C-h>";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = "<C-w>j";
        key = "<C-j>";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = "<C-w>k";
        key = "<C-k>";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = "<C-w>l";
        key = "<C-l>";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = "nzz";
        key = "n";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = "Nzz";
        key = "N";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = "*zz";
        key = "*";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = "#zz";
        key = "#";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = "g*zz";
        key = "g*";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = "g#zz";
        key = "g#";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = "^";
        key = "H";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = "$";
        key = "L";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = "^";
        key = "H";
        mode = "v";
        options = {
          silent = true;
        };
      }
      {
        action = "$";
        key = "L";
        mode = "v";
        options = {
          silent = true;
        };
      }
      {
        action = ":m '>+1<CR>gv=gv";
        key = "<A-j>";
        mode = "v";
        options = {
          silent = true;
        };
      }
      {
        action = ":m '<-1<CR>gv=gv";
        key = "<A-k>";
        mode = "v";
        options = {
          silent = true;
        };
      }
      {
        action = "<C-r>";
        key = "U";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = ":resize -2<CR>";
        key = "<Up>";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = ":resize +2<CR>";
        key = "<Down>";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = ":vertical resize -2<CR>";
        key = "<Right>";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = ":vertical resize +2<CR>";
        key = "<Left>";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = ":Neotree toggle<CR>";
        key = "<C-n>";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = ":Neotree reveal_file=%<CR>";
        key = "<Leader>k";
        mode = "n";
        options = {
          silent = true;
        };
      }
    ];

    plugins = {
      neo-tree = {
        enable = true;
      };

      tmux-navigator = {
        enable = true;
      };

      mini = {
        enable = true;

        modules = {
          bufremove = { };
          comment = {
            mappings = {
              comment = "gc";
              comment_line = "gcc";
              comment_visual = "gc";
              textobject = "gc";
            };
          };
          surround = {
            mappings = {
              add = "sa";
              delete = "sd";
              replace = "sr";
              suffix_last = "l";
              suffix_next = "n";
            };
          };
        };
      };

      lualine = {
        enable = true;
        globalstatus = true;
        extensions = [
          "fzf"
          "neo-tree"
        ];
        disabledFiletypes = {
          statusline = [
            "startup"
            "alpha"
          ];
        };
        theme = "catppuccin";
      };

      cmp = {
        enable = true;
        settings = {
          autoEnableSources = true;
          experimental = {
            ghost_text = false;
          };
          performance = {
            debounce = 60;
            fetchingTimeout = 200;
            maxViewEntries = 30;
          };
          snippet = {
            expand = "luasnip";
          };
          formatting = {
            fields = [
              "kind"
              "abbr"
              "menu"
            ];
          };
          sources = [
            {
              name = "buffer";
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
              keywordLength = 3;
            }
            {
              name = "path";
              keywordLength = 3;
            }
          ];

          window = {
            completion = {
              border = "solid";
            };
            documentation = {
              border = "solid";
            };
          };

          mapping = {
            "<C-Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<C-j>" = "cmp.mapping.select_next_item()";
            "<C-k>" = "cmp.mapping.select_prev_item()";
            "<C-e>" = "cmp.mapping.abort()";
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
          };
        };
      };

      cmp-buffer = {
        enable = true;
      };
      cmp-path = {
        enable = true;
      };
      cmp-cmdline = {
        enable = false;
      };

      telescope = {
        enable = true;
        extensions = {
          file-browser = {
            enable = true;
          };
          fzf-native = {
            enable = true;
          };
        };
        settings = {
          defaults = {
            layout_config = {
              horizontal = {
                prompt_position = "bottom";
              };
            };
            sorting_strategy = "descending";
          };
        };
        keymaps = {
          "<Leader><space>" = {
            action = "buffers";
            options = {
              desc = "Show buffers";
            };
          };
          "<space>gb" = {
            action = "git_branches";
            options = {
              desc = "Show git branches";
            };
          };
          "<space>gc" = {
            action = "git_bcommits";
            options = {
              desc = "Show buffer git commits";
            };
          };
          "<space>gf" = {
            action = "git_files";
            options = {
              desc = "Show git files";
            };
          };
          "<space>gs" = {
            action = "git_status";
            options = {
              desc = "Show git status";
            };
          };
          "<space>sa" = {
            action = "find_files";
            options = {
              desc = "Find files";
            };
          };
          "<space>sc" = {
            action = "colorscheme";
            options = {
              desc = "Select colorscheme";
            };
          };
          "<space>sd" = {
            action = "find_files";
            options = {
              desc = "Find dotfiles";
            };
          };
          "<space>sf" = {
            action = "live_grep";
            options = {
              desc = "Grep current word";
            };
          };
          "<space>sg" = {
            action = "live_grep";
            options = {
              desc = "Live grep";
            };
          };
          "<space>sh" = {
            action = "help_tags";
            options = {
              desc = "Show help tags";
            };
          };
          "<space>sk" = {
            action = "keymaps";
            options = {
              desc = "Show keymaps";
            };
          };
          "<space>sl" = {
            action = "resume";
            options = {
              desc = "Resume last search";
            };
          };
          "<space>sq" = {
            action = "quickfix";
            options = {
              desc = "Show quickfix";
            };
          };
          "<space>sr" = {
            action = "oldfiles";
            options = {
              desc = "Show recently opened files";
            };
          };
        };
      };
    };
  };
}
