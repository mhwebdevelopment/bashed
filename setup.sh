#!/usr/bin/env bash
PACK="$HOME/.local/share/nvim/site/pack/plugins/start"
mkdir -p "$PACK"

clone() {
  local name="$1" url="$2"
  if [ -d "$PACK/$name" ]; then
    echo "skip: $name"
  else
    git clone --depth 1 "$url" "$PACK/$name"
    echo "installed: $name"
  fi
}

clone "plenary.nvim"       "https://github.com/nvim-lua/plenary.nvim"
clone "telescope.nvim"     "https://github.com/nvim-telescope/telescope.nvim"
clone "rose-pine"          "https://github.com/rose-pine/neovim"
clone "nvim-treesitter"    "https://github.com/nvim-treesitter/nvim-treesitter"
clone "harpoon"            "https://github.com/ThePrimeagen/harpoon"
clone "vim-tmux-navigator" "https://github.com/christoomey/vim-tmux-navigator"
clone "undotree"           "https://github.com/mbbill/undotree"
clone "vim-fugitive"       "https://github.com/tpope/vim-fugitive"
clone "nvim-lspconfig"     "https://github.com/neovim/nvim-lspconfig"
clone "nvim-cmp"           "https://github.com/hrsh7th/nvim-cmp"
clone "cmp-nvim-lsp"       "https://github.com/hrsh7th/cmp-nvim-lsp"
clone "cmp-buffer"         "https://github.com/hrsh7th/cmp-buffer"
clone "cmp-path"           "https://github.com/hrsh7th/cmp-path"
clone "LuaSnip"            "https://github.com/L3MON4D3/LuaSnip"
clone "cmp_luasnip"        "https://github.com/saadparwaiz1/cmp_luasnip"

# Build Treesitter parsers once
nvim --headless -c "TSUpdate" -c "qa"
