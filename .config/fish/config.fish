set TTY (tty)
if [ "$(tty)" = "/dev/tty1" ]
    set -gx _JAVA_AWT_WM_NONREPARENTING 1
    set -gx XCURSOR_SIZE 24

    set -gx LIBVA_DRIVER_NAME nvidia
    set -gx XDG_SESSION_TYPE wayland
    set -gx GBM_BACKEND nvidia-drm
    set -gx __GLX_VENDOR_LIBRARY_NAME nvidia
    set -gx WLR_NO_HARDWARE_CURSORS 1

    set -gx GTK_THEME Adwaita:dark
    set -gx QT_STYLE_OVERRIDE adwaita

    exec Hyprland
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# fish default
set SHELL "fish"

# editor
set -x EDITOR "nvim"

# mode
fish_vi_key_bindings

# alias
alias vi="nvim"
alias vim="nvim"
alias lg="lazygit"
alias lf="lfcd"
alias venv="python -m venv"
alias ssh="kitty +kitten ssh"
alias dockerstart="sudo systemctl start docker"
alias exa="exa -s type"

# ls additions
source ~/.config/fish/ls.fish
set -gx LSCOLORS ExFxdxdxCxagababagacax

# greeting
set fish_greeting ""

# lf integration
source ~/.config/fish/lfcd.fish

# theme
source ~/.config/fish/themes/current.fish

# prompt
export STARSHIP_LOG=error
starship init fish | source

# paths
fish_add_path /usr/local/bin
fish_add_path ~/.local/bin
fish_add_path ~/.ghcup/bin
fish_add_path ~/.cargo/bin
fish_add_path /usr/lib/rustup/bin
fish_add_path /usr/lib/ruby/gems/3.0.0
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin

# rust cache
export RUSTC_WRAPPER=sccache

# pnpm
set -gx PNPM_HOME "/home/mihnea/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
