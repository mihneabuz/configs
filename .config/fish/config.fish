if [ "$(tty)" = "/dev/tty1" ]
  set -gx GDK_BACKEND "wayland,x11,*"
  gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
  gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
  gsettings set org.gnome.desktop.interface font-name "Ubuntu 11"

  set -gx QT_QPA_PLATFORM "wayland;xcb"
  set -gx QT_STYLE_OVERRIDE adwaita

  set -gx XCURSOR_SIZE 24
  set -gx _JAVA_AWT_WM_NONREPARENTING 1

  if [ "$(lsmod | grep nvidia_drm)" ];
    set -gx LIBVA_DRIVER_NAME nvidia
    set -gx XDG_SESSION_TYPE wayland
    set -gx GBM_BACKEND nvidia-drm
    set -gx __GLX_VENDOR_LIBRARY_NAME nvidia
    set -gx NVD_BACKEND direct
  end

  exec Hyprland
end

set -gx SHELL "/usr/bin/fish"
set -gx EDITOR "/usr/bin/nvim"

# greeting
set fish_greeting ""

# paths
fish_add_path /usr/local/bin
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/go/bin/
fish_add_path /usr/lib/rustup/bin
fish_add_path /usr/lib/ruby/gems/3.0.0

if status is-interactive
  fish_vi_key_bindings

  # alias
  alias vi  "nvim"
  alias vim "nvim"
  alias hx  "helix"
  alias lg  "lazygit"
  alias lf  "lfcd"
  alias exa "exa -s type"
  alias hist "commandline (history | fzf)"
  alias venv "python -m venv"
  alias dockerstart "sudo systemctl start docker"

  if set -q KITTY_WINDOW_ID
    alias ssh "kitty +kitten ssh"
  end

  # ls additions
  source ~/.config/fish/ls.fish
  set -gx LSCOLORS ExFxdxdxCxagababagacax

  # lf integration
  source ~/.config/fish/lfcd.fish

  # theme
  source ~/.config/fish/themes/current.fish

  # prompt
  set -gx STARSHIP_LOG error
  starship init fish | source
end
