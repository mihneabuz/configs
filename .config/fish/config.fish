if status is-interactive
    # Commands to run in interactive sessions can go here
end

# fish default
set SHELL "fish"

# editor
set -x EDITOR "nvim"

# alias
alias vi="NVIM_CLEAN=1 nvim"
alias vim="nvim"
alias vimdiff="nvim -d"

alias lg="lazygit"

alias venv="python -m venv"

alias dockerstart="sudo systemctl start docker"

# ls additions
source ~/.config/fish/ls.fish

# better clear
bind \cl 'for i in (seq 1 $LINES); echo; end; clear; commandline -f repaint'

# colors
set -Ux LSCOLORS ExFxdxdxCxagababagacax

# greeting
set fish_greeting ""

# prompt
export STARSHIP_LOG=error
starship init fish | source

fish_add_path /usr/local/bin
fish_add_path ~/.local/bin
fish_add_path ~/.ghcup/bin
fish_add_path ~/.cargo/bin
fish_add_path /usr/lib/ruby/gems/3.0.0
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin

# lf integration
alias lf="lfcd"
source ~/.config/fish/lfcd.fish

# pnpm
set -gx PNPM_HOME "/home/mihnea/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end

source ~/.config/fish/themes/current.fish
