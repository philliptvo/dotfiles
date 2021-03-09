if status --is-interactive
  set theme_color_scheme gruvbox
  #set -g fish_user_paths "/usr/local/texlive/2020/bin/x86_64-darwin" $fish_user_paths
  set -xg fish_user_paths "/usr/local/texlive/2020/bin/x86_64-darwin" "$HOME/.scripts" "$HOME/.local/bin" $fish_user_paths
  set -xg EDITOR "nvim"
  set -xg BROWSER ""
  set -xg NOTES_DIR "$HOME/notes"

  pyenv init - | source
end
