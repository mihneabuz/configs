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

fish_add_path /usr/lib/ruby/gems/3.0.0
