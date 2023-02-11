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
alias rr="ranger"

alias gs="git status"
alias gd="git diff"

alias venv="python -m venv"

# ls additions
source ~/.config/fish/ls.fish

# better clear
bind \cl 'for i in (seq 1 $LINES); echo; end; clear; commandline -f repaint'

# colors
set -Ux LSCOLORS ExFxdxdxCxagababagacax

set -U fish_color_normal normal
set -U fish_color_command blue --bold
set -U fish_color_quote green
set -U fish_color_redirection yellow --bold
set -U fish_color_end ff8f40
set -U fish_color_error red
set -U fish_color_param normal
set -U fish_color_comment 626A73 --italics
set -U fish_color_match red
set -U fish_color_selection --background=ffc2ff
set -U fish_color_search_match --background=31353f
set -U fish_color_history_current --bold
set -U fish_color_operator yellow
set -U fish_color_valid_path --bold
set -U fish_pager_color_completion cyan
set -U fish_pager_color_descexitription magenta
set -U fish_pager_color_prefix cyan --italics
set -U fish_pager_color_progress blue

# greeting
set fish_greeting ""

# prompt
starship init fish | source

fish_add_path ~/.local/bin
fish_add_path ~/.ghcup/bin
fish_add_path ~/.cargo/bin
fish_add_path /usr/lib/ruby/gems/3.0.0

# lf integration
alias lf="lfcd"
source ~/.config/fish/lfcd.fish

if type -q pnpm
  alias npm="pnpm"
end
# pnpm
set -gx PNPM_HOME "/home/mihnea/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
