# ~/.profile: executed by the command interpreter for login shells.
#
# This file is not read by bash if ~/.bash_profile or ~/.bash_login exits.

# On OS X /etc/profile contains the code below without the PATH="". This causes
# duplicate $PATH entries when $PATH is already set. So call path_helper again
# with an empty $PATH to avoid ending up with duplicate entries.
if [ -x /usr/libexec/path_helper ]; then
  PATH=""
  eval `/usr/libexec/path_helper -s`
fi

# Source $HOME/toolbox/toolbox.profile if is readable.
if [ -r "$HOME/toolbox/toolbox.profile" ]; then
  . $HOME/toolbox/toolbox.profile
fi

# Add $HOME/.bin to the front of $PATH if it exists and $PATH does not already
# contain $HOME/.bin .
if [ -d "$HOME/.bin" ]; then
  case ":$PATH:" in
    *:$HOME/.bin:*) ;;
    *) export PATH=$HOME/.bin:$PATH ;;
  esac
fi

# Add $HOME/bin to the front of $PATH if it exists and $PATH does not already
# contain $HOME/bin .
if [ -d "$HOME/bin" ]; then
  case ":$PATH:" in
    *:$HOME/bin:*) ;;
    *) export PATH=$HOME/bin:$PATH ;;
  esac
fi

# On OS X the LC_CTYPE environment variable is set to UTF-8 by default. This is
# not supported on Linux so set it to en_US.UTF-8 instead.
if [ "$LC_CTYPE" = "UTF-8" ]; then
  LC_CTYPE=en_US.UTF-8
fi

if command -v vim >/dev/null 2>&1; then
  export VISUAL=vim
fi

# Source local profile settings from .profile.local if it is readable.
if [ -r "$HOME/.profile.local" ]; then
  . "$HOME/.profile.local"
fi
