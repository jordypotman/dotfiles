if [ -n "$_jordy_bash_functions_sourced" ]; then return; fi
_jordy_bash_functions_sourced=true

# Prepend, append or remove an entry to/from a variable with entries separated
# by a specifc separator.
# Based on https://unix.stackexchange.com/a/634670
jordy_edit_separated_var() {
  [[ -z $2 ]] && return 1
  [[ -z $3 ]] && return 1
  [[ -z $4 ]] && return 1
  local action=$1
  local entry=$2
  local var_name=$3
  local sep=$4
  # Set $value to the value of the variable in $var_name.
  local value=${!var_name}
  # Surround $value with $sep to simplify matching.
  value="$sep$value$sep"
  # Remove all occurences of $entry from $value.
  value=${value//$sep$entry$sep/}
  case $action in
    -p ) value=$entry$value ;;
    -a ) value=$value$entry ;;
    -r ) ;;
    * ) return 1 ;;
  esac
  # Replace any duplicate $sep in $value with a single $sep.
  while [[ $value == *$sep$sep* ]] ; do
    value=${value//$sep$sep/$sep}
  done
  # Remove $sep from the begin of $value.
  value=${value#$sep}
  # Remove $sep from the end of $value.
  value=${value%$sep}
  # Set the variable in $var_name to the value of $value.
  printf -v "$var_name" %s "$value"
}

# Prepend, append or remove an entry to/from a path variable such as $PATH or
# $MANPATH.
jordy_edit_path_var() {
  [[ -z $2 ]] && return 1
  [[ -z $3 ]] && return 1
  jordy_edit_separated_var "$1" "$2" "$3" ":"
}

# Prepend, append or remove an entry to/from $PATH.
jordy_edit_path() {
  jordy_edit_path_var "$1" "$2" PATH
}

# Prepend a directory to $PATH if it exists.
jordy_prepend_path() {
  [[ -d $1 ]] || return 0
  jordy_edit_path -p "$1"
}

# Prepend, append or remove an entry to/from $MANPATH.
jordy_edit_manpath() {
  jordy_edit_path_var "$1" "$2" MANPATH
}

# Prepend a directory to $MANPATH if it exists.
jordy_prepend_manpath() {
  [[ -d $1 ]] || return 0
  jordy_edit_manpath -p "$1"
}

# Prepend, append or remove an entry to/from $JORDY_ENV_PROMPT.
jordy_edit_env_prompt() {
  jordy_edit_separated_var "$1" "$2" JORDY_ENV_PROMPT " "
}

# Prepend an entry to $JORDY_ENV_PROMPT.
jordy_prepend_env_prompt() {
  jordy_edit_env_prompt -p "$1"
}
