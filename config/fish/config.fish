if status --is-interactive
  set theme_color_scheme gruvbox
  #set -g fish_user_paths "/usr/local/texlive/2020/bin/x86_64-darwin" $fish_user_paths
  set -gx PATH "/usr/local/texlive/2020/bin/x86_64-darwin" "$HOME/.local/bin" $PATH

  pyenv init - | source
end
