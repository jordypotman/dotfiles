# ~/.bashrc: executed by bash for non-login shells.

# Read functions from ~/.jordy/bash_functions
if [ -r "$HOME/.jordy/bash_functions.sh" ]; then
  source "$HOME/.jordy/bash_functions.sh"
fi

# Read and execute commands for interactive shells from ~/.bash_interactive.
if [ -r "$HOME/.bash_interactive" ]; then
  source "$HOME/.bash_interactive"
fi

# Source local bashrc settings from ~/.bashrc.local if it is readable.
if [  -r "$HOME/.bashrc.local" ]; then
  source "$HOME/.bashrc.local"
fi
