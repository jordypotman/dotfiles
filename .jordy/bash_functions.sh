if [ -n "$_jordy_bash_functions_sourced" ]; then return; fi
_jordy_bash_functions_sourced=true

# Prepend, append or remove an entry to/from a path variable such as $PATH or
# $MANPATH.
# Based on https://unix.stackexchange.com/a/634670
jordy_edit_path_var() {
  [[ -z $2 ]] && return 1
  [[ -z $3 ]] && return 1
  local path_var=$3
  # Set path to the value of the variable in $path_var.
  local path=${!path_var}
  # Prepend and append : to $path.
  path=:$path:
  # Remove any occurences of $2 from $path.
  path=${path//:$2:/}
  case $1 in
    -p ) path=$2$path ;;
    -a ) path=$path$2 ;;
    -r ) ;;
    * ) return 1 ;;
  esac
  # Replace any :: in $path with :.
  while [[ $path == *::* ]] ; do
    path=${path//::/:}
  done
  # Remove : from the begin of $path.
  path=${path#:}
  # Remove : from the end of $path.
  path=${path%:}
  # Set the variable in $path_var to the value of $path.
  eval "$path_var=\$path"
}

# Prepend, append or remove an entry to/from $PATH.
jordy_edit_path() {
  jordy_edit_path_var $1 $2 PATH
}

# Prepend a directory to $PATH if it exists.
jordy_prepend_path() {
  [[ -d $1 ]] || return 0
  jordy_edit_path -p $1
}

# Prepend, append or remove an entry to/from $MANPATH.
jordy_edit_manpath() {
  jordy_edit_path_var $1 $2 MANPATH
}

# Prepend a directory to $MANPATH if it exists.
jordy_prepend_manpath() {
  [[ -d $1 ]] || return 0
  jordy_edit_manpath -p $1
}
