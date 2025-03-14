jordy_get_tools_dir() {
  echo "/SCRATCH/jordy/tools"
}

jordy_download_build_install_neovim() {
  # https://github.com/neovim/neovim/archive/refs/tags/v0.10.4.tar.gz
  NEOVIM_SRC_URL="https://github.com/neovim/neovim/archive/refs/tags/"
  NEOVIM_VERSION="0.10.4"

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
