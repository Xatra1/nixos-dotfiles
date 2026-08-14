# Environment variables to force insubordinate programs into following the XDG
# Base Directory specification
{
  home.sessionVariables = {
    CUDA_CACHE_PATH = "$HOME/.cache/nv";

    GTK2_RC_FILES = "$HOME/.config/gtk-2.0/gtkrc";
    WGETRC = "$HOME/.config/wgetrc";

    HISTFILE = "$HOME/.local/state/bash_history";

    ANDROID_USER_HOME = "$HOME/.local/share/android";
    GNUPGHOME = "$HOME/.local/share/gnupg";
    RUSTUP_HOME = "$HOME/.local/share/rustup";
    CARGO_HOME = "$HOME/.local/share/cargo";
    WINEPREFIX = "$HOME/.local/share/wine";
  };
}
