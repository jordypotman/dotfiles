jordy_get_tools_dir() {
  echo "/SCRATCH/jordy/tools"
}

jordy_get_num_make_jobs() {
  echo "48"
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
  ([ -d "${install_prefix}" ] || CC=$(which gcc) ../configure --disable-werror --prefix="${install_prefix}" && make -j $(jordy_get_num_make_jobs) install) && \
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
