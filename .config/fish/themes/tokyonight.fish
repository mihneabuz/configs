# Upstream: https://github.com/folke/tokyonight.nvim/blob/main/extras/fish/tokyonight_night.fish
# Syntax Highlighting Colors
set -Ux fish_color_normal normal
set -Ux fish_color_command --bold blue
set -Ux fish_color_keyword magenta
set -Ux fish_color_quote green
set -Ux fish_color_redirection --bold yellow
set -Ux fish_color_end --bold yellow
set -Ux fish_color_error red
set -Ux fish_color_param --bold brwhite
set -Ux fish_color_valid_path cyan
set -Ux fish_color_comment 565f89
set -Ux fish_color_selection --background=33467c
set -Ux fish_color_search_match --background=33467c
set -Ux fish_color_operator --bold red
set -Ux fish_color_escape yellow
set -Ux fish_color_autosuggestion 565f89

# Completion Pager Colors
set -Ux fish_pager_color_progress 565f89
set -Ux fish_pager_color_prefix 7dcfff
set -Ux fish_pager_color_completion c0caf5
set -Ux fish_pager_color_description 565f89
set -Ux fish_pager_color_selected_background --background=33467c

export COLORSCHEME=tokyonight
