# ~/.bash_profile: read and executed by bash for login shells.

# Read functions from ~/.jordy/bash_functions.sh
if [ -r "$HOME/.jordy/bash_functions.sh" ]; then
  source "$HOME/.jordy/bash_functions.sh"
fi

# Explicitly read and execute commands from ~/.profile if it is readable
# because ~/.profile is not read by bash if ~/.bash_profile exists and is
# readable.
if [ -r "$HOME/.profile" ]; then
  source "$HOME/.profile"
fi

# Read and execute commands for interactive shells from ~/.bash_interactive.
if [ -r "$HOME/.bash_interactive" ]; then
  source "$HOME/.bash_interactive"
fi
