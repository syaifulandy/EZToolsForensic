#!/bin/bash

# Warna untuk output
GREEN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'

# Lokasi instalasi = folder tempat skrip ini dijalankan
INSTALL_DIR="$(dirname "$(realpath "$0")")/EricZimmermansTools"

# Cek shell yang digunakan
if [[ $SHELL == */zsh ]]; then
  SHELL_RC="$HOME/.zshrc"
else
  SHELL_RC="$HOME/.bashrc"
fi

# Daftar tools dan nama alias
declare -A tools=(
  [AmcacheParser]=amcacheparser
  [AppCompatCacheParser]=appcompatcacheparser
  [EvtxECmd]=evtxecmd
  [JLECmd]=jlecmd
  [LECmd]=lecmd
  [MFTECmd]=mftecmd
  [PECmd]=pecmd
  [RBCmd]=rbcmd
  [RecentFileCacheParser]=recentfilecacheparser
  [RECmd]=recmd
  [SBECmd]=sbecmd
  [SQLECmd]=sqlecmd
  [SrumECmd]=srumecmd
  [SumECmd]=sumecmd
  [WxTCmd]=wxtcmd
)

mkdir -p "$INSTALL_DIR"

echo "--------------------------------------------------------------------------------------------"
echo "Downloading and installing tools to $INSTALL_DIR..."

for tool in "${!tools[@]}"; do
  url="https://download.ericzimmermanstools.com/net9/${tool}.zip"
  zip_file="${tool}.zip"
  dest="$INSTALL_DIR/$tool"

  echo "Installing $tool..."
  wget -q "$url" -O "$zip_file" && \
  mkdir -p "$dest" && \
  unzip -o "$zip_file" -d "$dest" > /dev/null && \
  rm -f "$zip_file"

  if [[ $? -eq 0 ]]; then
    echo "${GREEN}Installed ${tool}.${NC}"
  else
    echo "${RED}Failed to install ${tool}.${NC}"
  fi
done

echo "--------------------------------------------------------------------------------------------"
echo "Adding aliases to $SHELL_RC..."

# Tambah alias dotnet
echo "alias dotnet='~/.dotnet/dotnet'" >> "$SHELL_RC"

# Tambah alias untuk semua tools
for tool in "${!tools[@]}"; do
  alias_name="${tools[$tool]}"
  tool_path="$INSTALL_DIR/$tool/${tool}.dll"
  echo "alias $alias_name='dotnet \"$tool_path\"'" >> "$SHELL_RC"
done

echo "${GREEN}All aliases added.${NC}"

echo "--------------------------------------------------------------------------------------------"
echo "Selesai. Jalankan 'source $SHELL_RC' atau buka terminal baru untuk mulai memakai tools ini."
