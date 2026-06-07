jordy_get_tools_dir() {
  ([ -d "/SCRATCH/jordy" ] && echo "/SCRATCH/jordy/tools" && return) || \
    echo "$HOME/tools"
}

jordy_setup_tools_build_env() {
  export PATH="$(jordy_get_tools_dir)/install/bin${PATH:+:$PATH}"
  export PKG_CONFIG_PATH="$(jordy_get_tools_dir)/install/lib/pkgconfig:$(jordy_get_tools_dir)/install/lib64/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
  export CC=$(which gcc)
}

jordy_get_num_parallel_jobs() {
  echo "$(nproc)"
}

jordy_download_build_install_openssl() {
  # https://github.com/openssl/openssl/releases/download/openssl-3.5.6/openssl-3.5.6.tar.gz
  local OPENSSL_SRC_URL="https://github.com/openssl/openssl/releases/download"
  local OPENSSL_VERSION="3.5.6"

  local tools_dir=$(jordy_get_tools_dir)
  local tools_openssl_dir="${tools_dir}/openssl"
  local archive_name="openssl-${OPENSSL_VERSION}.tar.gz"
  local dir_name="openssl-${OPENSSL_VERSION}"
  local install_prefix="${tools_openssl_dir}/installs/${dir_name}"

  mkdir -p "${tools_openssl_dir}" && \
  pushd "${tools_openssl_dir}" > /dev/null && \
  ([ -f "${archive_name}" ] || wget "${OPENSSL_SRC_URL}/${dir_name}/${archive_name}") && \
  ([ -d "${dir_name}" ] || tar zxf "${archive_name}") && \
  cd "${dir_name}" && \
  ([ -d "${install_prefix}" ] || (./Configure --prefix="${install_prefix}" && \
    make -j $(jordy_get_num_parallel_jobs) && make -j $(jordy_get_num_parallel_jobs) install)) && \
  cd "${install_prefix}/.." && \
  ln -sfn "${dir_name}" openssl && \
  cp -Rsf "${PWD}/openssl"/* "${tools_dir}/install/" && \
  popd > /dev/null
}

jordy_download_build_install_libevent() {
  # https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz
  local LIBEVENT_SRC_URL="https://github.com/libevent/libevent/releases/download"
  local LIBEVENT_VERSION="2.1.12"

  local tools_dir=$(jordy_get_tools_dir)
  local tools_libevent_dir="${tools_dir}/libevent"
  local archive_name="libevent-${LIBEVENT_VERSION}-stable.tar.gz"
  local dir_name="libevent-${LIBEVENT_VERSION}-stable"
  local install_prefix="${tools_libevent_dir}/installs/${dir_name}"

  mkdir -p "${tools_libevent_dir}" && \
  pushd "${tools_libevent_dir}" > /dev/null && \
  ([ -f "${archive_name}" ] || wget "${LIBEVENT_SRC_URL}/release-${LIBEVENT_VERSION}-stable/${archive_name}") && \
  ([ -d "${dir_name}" ] || tar zxf "${archive_name}") && \
  cd "${dir_name}" && \
  ([ -d "${install_prefix}" ] || (./configure --prefix="${install_prefix}" && \
    make -j $(jordy_get_num_parallel_jobs) && make -j $(jordy_get_num_parallel_jobs) install)) && \
  cd "${install_prefix}/.." && \
  ln -sfn "${dir_name}" libevent && \
  cp -Rsf "${PWD}/libevent"/* "${tools_dir}/install/" && \
  popd > /dev/null
}

jordy_download_build_install_m4() {
  https://ftp.gnu.org/gnu/m4/m4-1.4.21.tar.gz
  local M4_SRC_URL="https://ftp.gnu.org/gnu/m4"
  local M4_VERSION="1.4.21"

  local tools_dir=$(jordy_get_tools_dir)
  local tools_m4_dir="${tools_dir}/m4"
  local archive_name="m4-${M4_VERSION}.tar.gz"
  local dir_name="m4-${M4_VERSION}"
  local install_prefix="${tools_m4_dir}/installs/${dir_name}"

  mkdir -p "${tools_m4_dir}" && \
  pushd "${tools_m4_dir}" > /dev/null && \
  ([ -f "${archive_name}" ] || wget "${M4_SRC_URL}/${archive_name}") && \
  ([ -d "${dir_name}" ] || tar zxf "${archive_name}") && \
  cd "${dir_name}" && \
  ([ -d "${install_prefix}" ] || (./configure --prefix="${install_prefix}" && \
    make -j $(jordy_get_num_parallel_jobs) && make -j $(jordy_get_num_parallel_jobs) install)) && \
  cd "${install_prefix}/.." && \
  ln -sfn "${dir_name}" m4 && \
  cp -Rsf "${PWD}/m4"/* "${tools_dir}/install/" && \
  popd > /dev/null
}

jordy_download_build_install_bison() {
  # https://ftp.gnu.org/gnu/bison/bison-3.8.tar.gz
  local BISON_SRC_URL="https://ftp.gnu.org/gnu/bison"
  local BISON_VERSION="3.8"

  local tools_dir=$(jordy_get_tools_dir)
  local tools_bison_dir="${tools_dir}/bison"
  local archive_name="bison-${BISON_VERSION}.tar.gz"
  local dir_name="bison-${BISON_VERSION}"
  local install_prefix="${tools_bison_dir}/installs/${dir_name}"

  mkdir -p "${tools_bison_dir}" && \
  pushd "${tools_bison_dir}" > /dev/null && \
  ([ -f "${archive_name}" ] || wget "${BISON_SRC_URL}/${archive_name}") && \
  ([ -d "${dir_name}" ] || tar zxf "${archive_name}") && \
  cd "${dir_name}" && \
  ([ -d "${install_prefix}" ] || (./configure --prefix="${install_prefix}" && \
    make -j $(jordy_get_num_parallel_jobs) && make -j $(jordy_get_num_parallel_jobs) install)) && \
  cd "${install_prefix}/.." && \
  ln -sfn "${dir_name}" bison && \
  cp -Rsf "${PWD}/bison"/* "${tools_dir}/install/" && \
  popd > /dev/null
}

jordy_download_build_install_ncurses() {
  # https://invisible-island.net/archives/ncurses/ncurses-6.6.tar.gz
  local NCURSES_SRC_URL="https://invisible-island.net/archives/ncurses"
  local NCURSES_VERSION="6.6"

  local tools_dir=$(jordy_get_tools_dir)
  local tools_ncurses_dir="${tools_dir}/ncurses"
  local archive_name="ncurses-${NCURSES_VERSION}.tar.gz"
  local dir_name="ncurses-${NCURSES_VERSION}"
  local install_prefix="${tools_ncurses_dir}/installs/${dir_name}"

  mkdir -p "${tools_ncurses_dir}" && \
  pushd "${tools_ncurses_dir}" > /dev/null && \
  ([ -f "${archive_name}" ] || wget "${NCURSES_SRC_URL}/${archive_name}") && \
  ([ -d "${dir_name}" ] || tar zxf "${archive_name}") && \
  cd "${dir_name}" && \
  ([ -d "${install_prefix}" ] || (./configure --prefix="${install_prefix}" --with-shared --with-termlib --enable-pc-files --with-pkg-config-libdir="${install_prefix}/lib/pkgconfig" && \
    make -j $(jordy_get_num_parallel_jobs) && make -j $(jordy_get_num_parallel_jobs) install)) && \
  cd "${install_prefix}/.." && \
  ln -sfn "${dir_name}" ncurses && \
  cp -Rsf "${PWD}/ncurses"/* "${tools_dir}/install/" && \
  popd > /dev/null
}

jordy_download_build_install_tmux() {
  # https://github.com/tmux/tmux/releases/download/3.6b/tmux-3.6b.tar.gz
  local TMUX_SRC_URL="https://github.com/tmux/tmux/releases/download"
  local TMUX_VERSION="3.6b"

  local tools_dir=$(jordy_get_tools_dir)
  local tools_tmux_dir="${tools_dir}/tmux"
  local archive_name="tmux-${TMUX_VERSION}.tar.gz"
  local dir_name="tmux-${TMUX_VERSION}"
  local install_prefix="${tools_tmux_dir}/installs/${dir_name}"

  mkdir -p "${tools_tmux_dir}" && \
  pushd "${tools_tmux_dir}" > /dev/null && \
  ([ -f "${archive_name}" ] || wget "${TMUX_SRC_URL}/${TMUX_VERSION}/${archive_name}") && \
  ([ -d "${dir_name}" ] || tar zxf "${archive_name}") && \
  cd "${dir_name}" && \
  ([ -d "${install_prefix}" ] || (./configure --prefix="${install_prefix}" && \
    make -j $(jordy_get_num_parallel_jobs) && make -j $(jordy_get_num_parallel_jobs) install)) && \
  cd "${install_prefix}/.." && \
  ln -sfn "${dir_name}" tmux && \
  cp -Rsf "${PWD}/tmux"/* "${tools_dir}/install/" && \
  popd > /dev/null
}

jordy_download_build_install_make() {
  # https://ftp.gnu.org/gnu/make/make-4.4.1.tar.gz
  local MAKE_SRC_URL="https://ftp.gnu.org/gnu/make"
  local MAKE_VERSION="4.4.1"

  local tools_dir=$(jordy_get_tools_dir)
  local tools_make_dir="${tools_dir}/make"
  local archive_name="make-${MAKE_VERSION}.tar.gz"
  local dir_name="make-${MAKE_VERSION}"
  local install_prefix="${tools_make_dir}/installs/${dir_name}"

  mkdir -p "${tools_make_dir}" && \
  pushd "${tools_make_dir}" > /dev/null && \
  ([ -f "${archive_name}" ] || wget "${MAKE_SRC_URL}/${archive_name}") && \
  ([ -d "${dir_name}" ] || tar zxf "${archive_name}") && \
  cd "${dir_name}" && \
  ([ -d "${install_prefix}" ] || (./configure --prefix="${install_prefix}" && \
    make -j $(jordy_get_num_parallel_jobs) install)) && \
  cd "${install_prefix}/.." && \
  ln -sfn "${dir_name}" make && \
  popd > /dev/null
}

jordy_download_build_install_neovim() {
  # https://github.com/neovim/neovim/archive/refs/tags/v0.11.3.tar.gz
  NEOVIM_SRC_URL="https://github.com/neovim/neovim/archive/refs/tags/"
  NEOVIM_VERSION="0.11.3"

  tools_dir=$(jordy_get_tools_dir)
  tools_neovim_dir="${tools_dir}/neovim"
  archive_name="v${NEOVIM_VERSION}.tar.gz"
  dir_name="neovim-${NEOVIM_VERSION}"
  install_prefix="${tools_neovim_dir}/installs/${dir_name}"

  mkdir -p "${tools_neovim_dir}" && \
  pushd "${tools_neovim_dir}" > /dev/null && \
  ([ -f "${archive_name}" ] || wget "${NEOVIM_SRC_URL}${archive_name}") && \
  ([ -d "${dir_name}" ] || tar zxf "${archive_name}") && \
  cd "${dir_name}" && \
  ([ -d "${install_prefix}" ] || CC=$(which gcc) make CMAKE_BUILD_TYPE=Release \
  DEPS_CMAKE_FLAGS=-DTREESITTER_ARGS=-DCMAKE_C_FLAGS=-D_BSD_SOURCE \
  CMAKE_INSTALL_PREFIX="${install_prefix}" install) && \
  cd "${install_prefix}" && \
  ([ -L "lib" ] || ln -s lib64 lib) && \
  cd .. && \
  ln -sfn "${dir_name}" neovim && \
  popd > /dev/null
}

jordy_download_build_install_curl() {
  # https://curl.se/download/curl-8.12.1.tar.gz
  CURL_SRC_URL="https://curl.se/download/"
  CURL_VERSION="8.12.1"

  tools_dir=$(jordy_get_tools_dir)
  tools_curl_dir="${tools_dir}/curl"
  archive_name="curl-${CURL_VERSION}.tar.gz"
  dir_name="curl-${CURL_VERSION}"
  install_prefix="${tools_curl_dir}/installs/${dir_name}"

  mkdir -p "${tools_curl_dir}" && \
  pushd "${tools_curl_dir}" > /dev/null && \
  ([ -f "${archive_name}" ] || wget "${CURL_SRC_URL}${archive_name}") && \
  ([ -d "${dir_name}" ] || tar zxf "${archive_name}") && \
  cd "${dir_name}" && \
  ([ -d "${install_prefix}" ] || CC=$(which gcc) ./configure --with-openssl --without-libpsl --prefix="${install_prefix}" && make install) && \
  cd "${install_prefix}/.." && \
  ln -sfn "${dir_name}" curl && \
  popd > /dev/null
}

jordy_download_build_install_glic_2_28() {
  # https://ftp.gnu.org/gnu/glibc/glibc-2.28.tar.gz
  # To get user name resolving working for programs using this glibc
  # /usr/lib64/libnss_sss.so.2 has to be manually symlinked into the lib
  # directory of the install prefix.
  GLIBC_SRC_URL="https://ftp.gnu.org/gnu/glibc/"
  GLIBC_VERSION="2.28"

  tools_dir=$(jordy_get_tools_dir)
  tools_glibc_dir="${tools_dir}/glibc"
  archive_name="glibc-${GLIBC_VERSION}.tar.gz"
  dir_name="glibc-${GLIBC_VERSION}"
  install_prefix="${tools_glibc_dir}/installs/${dir_name}"

  mkdir -p "${tools_glibc_dir}" && \
  pushd "${tools_glibc_dir}" > /dev/null && \
  ([ -f "${archive_name}" ] || wget "${GLIBC_SRC_URL}${archive_name}") && \
  ([ -d "${dir_name}" ] || tar zxf "${archive_name}") && \
  cd "${dir_name}" && \
  mkdir -p build && cd build && \
  ([ -d "${install_prefix}" ] || CC=$(which gcc) ../configure --disable-werror --prefix="${install_prefix}" && make -j $(jordy_get_num_parallel_jobs) install) && \
  popd > /dev/null
}

jordy_download_build_install_patchelf() {
  # https://github.com/NixOS/patchelf/archive/refs/tags/0.15.5.tar.gz
  PATCHELF_SRC_URL="https://github.com/NixOS/patchelf/archive/refs/tags/"
  PATCHELF_VERSION="0.15.5"

  tools_dir=$(jordy_get_tools_dir)
  tools_patchelf_dir="${tools_dir}/patchelf"
  archive_name="${PATCHELF_VERSION}.tar.gz"
  dir_name="patchelf-${PATCHELF_VERSION}"
  install_prefix="${tools_patchelf_dir}/installs/${dir_name}"

  mkdir -p "${tools_patchelf_dir}" && \
  pushd "${tools_patchelf_dir}" > /dev/null && \
  ( [ -f "${archive_name}" ] || wget "${PATCHELF_SRC_URL}${archive_name}") && \
  ( [ -d "${dir_name}" ] || tar zxf "${archive_name}") && \
  cd "${dir_name}" && \
  ( [ -d "${install_prefix}" ] || CC=$(which gcc) ./bootstrap.sh && ./configure --prefix="${install_prefix}" && make install) && \
  cd "${install_prefix}/.." && \
  ln -sfn "${dir_name}" patchelf && \
  popd > /dev/null
}
