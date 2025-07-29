{
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

    # do not replace yank on multiple paste
    {
      action = "pgvy";
      key = "p";
      mode = "x";
      options = {
        silent = true;
      };
    }

    # line indentation
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

    # visual search
    {
      action = "<Esc>/\\%V";
      key = "/";
      mode = "x";
      options = {
        silent = true;
      };
    }

    # navigation
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

    # start / end of line
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

    # move code
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

    # redo
    {
      action = "<C-r>";
      key = "U";
      mode = "n";
      options = {
        silent = true;
      };
    }

    # window resizing
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

    # buffer navigation
    {
      action = ":bnext<CR>";
      key = "<TAB>";
      mode = "n";
      options = {
        silent = true;
      };
    }
    {
      action = ":bprevious<CR>";
      key = "<TAB>";
      mode = "n";
      options = {
        silent = true;
      };
    }

    # buffer split
    {
      action = "<C-w>v";
      key = "vv";
      mode = "n";
      options = {
        silent = true;
      };
    }
    {
      action = "<C-w>s";
      key = "ss";
      mode = "n";
      options = {
        silent = true;
      };
    }
  ];
}
