#!/bin/bash

GREEN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'

# Lokasi folder instalasi
INSTALL_DIR="$(dirname "$(realpath "$0")")/EricZimmermansTools"

# Deteksi shell yang digunakan
if [[ $SHELL == */zsh ]]; then
  SHELL_RC="$HOME/.zshrc"
else
  SHELL_RC="$HOME/.bashrc"
fi

# Daftar nama tools dan alias
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

echo "--------------------------------------------------------------------------------------------"
echo "Menghapus direktori $INSTALL_DIR..."
rm -rf "$INSTALL_DIR"

if [[ $? -eq 0 ]]; then
  echo "${GREEN}Direktori berhasil dihapus.${NC}"
else
  echo "${RED}Gagal menghapus direktori.${NC}"
fi

echo "--------------------------------------------------------------------------------------------"
echo "Menghapus alias dari $SHELL_RC..."

# Hapus semua baris alias yang berkaitan
sed -i '/alias dotnet='\''~\/\.dotnet\/dotnet'\''/d' "$SHELL_RC"

for tool in "${!tools[@]}"; do
  alias_name="${tools[$tool]}"
  sed -i "/alias $alias_name='dotnet .*${tool}.dll'/d" "$SHELL_RC"
done

echo "${GREEN}Alias berhasil dihapus.${NC}"
echo "--------------------------------------------------------------------------------------------"
echo "Selesai. Jalankan 'source $SHELL_RC' atau buka terminal baru untuk memperbarui shell."
