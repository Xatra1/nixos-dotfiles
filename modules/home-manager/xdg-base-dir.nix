# Environment variables to force insubordinate programs into following the XDG
# Base Directory specification
{
  home.sessionVariables = {
    CUDA_CACHE_PATH = "$HOME/.cache/nv";

    GTK2_RC_FILES = "$HOME/.config/gtk-2.0/gtkrc";
    WGETRC = "$HOME/.config/wgetrc";

    HISTFILE = "$HOME/.local/state/bash_history";

    GNUPGHOME = "$HOME/.local/share/gnupg";
    WINEPREFIX = "$HOME/.local/share/wine";
  };
}
