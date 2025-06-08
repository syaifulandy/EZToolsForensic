#!/bin/bash
GREEN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'

clear

echo "--------------------------------------------------------------------------------------------"
echo "Assuming curl and unzip are already installed." 1>&2

INSTALL_DIR="$HOME"
DOTNET_DIR="$INSTALL_DIR/dotnet"
DOTNET_BIN="$DOTNET_DIR/dotnet"
mkdir -p "$INSTALL_DIR"

echo "--------------------------------------------------------------------------------------------"
echo "Installing .NET 9..." 1>&2

DOTNET_INSTALL_SCRIPT="$INSTALL_DIR/dotnet-install.sh"
if curl -sSL https://dot.net/v1/dotnet-install.sh -o "$DOTNET_INSTALL_SCRIPT" && \
   chmod +x "$DOTNET_INSTALL_SCRIPT" && \
   "$DOTNET_INSTALL_SCRIPT" --channel 9.0 --install-dir "$DOTNET_DIR" > /dev/null && \
   rm -f "$DOTNET_INSTALL_SCRIPT"; then
    echo "${GREEN}.NET 9 installed.${NC}" 1>&2
else
    echo "${RED}ERROR: Couldn't install .NET 9.${NC}" 1>&2
fi

# Tambahkan dotnet ke PATH dan alias (zsh)
echo "export PATH=\"\$PATH:$DOTNET_DIR\"" >> ~/.zshrc
echo "alias dotnet='$DOTNET_BIN'" >> ~/.zshrc

# Fungsi download dan unzip
download_and_unzip() {
  local url="$1"
  local dest_dir="$2"
  local zip_name=$(basename "$url")
  echo "--------------------------------------------------------------------------------------------" 1>&2
  echo "Downloading ${zip_name}..." 1>&2
  mkdir -p "$dest_dir"
  if curl -sSL "$url" -o "$INSTALL_DIR/$zip_name" && unzip "$INSTALL_DIR/$zip_name" -d "$dest_dir" > /dev/null 2>&1 && rm -f "$INSTALL_DIR/$zip_name"; then
    echo "${GREEN}${zip_name} installed.${NC}" 1>&2
  else
    echo "${RED}ERROR: Couldn't install ${zip_name}.${NC}" 1>&2
  fi
}

# Daftar tool dan alias
TOOLS=(
  "AmcacheParser"
  "AppCompatCacheParser"
  "EvtxECmd"
  "JLECmd"
  "LECmd"
  "MFTECmd"
  "PECmd"
  "RBCmd"
  "RecentFileCacheParser"
  "RECmd"
  "SBECmd"
  "SQLECmd"
  "SrumECmd"
  "SumECmd"
  "WxTCmd"
)

# Unduh dan pasang semua tools
for tool in "${TOOLS[@]}"; do
  download_and_unzip "https://download.ericzimmermanstools.com/net9/${tool}.zip" "$INSTALL_DIR/$tool"
  echo "alias ${tool,,}='dotnet $INSTALL_DIR/$tool/${tool}.dll'" >> ~/.zshrc
done

echo "--------------------------------------------------------------------------------------------"
echo "${GREEN}Setup complete. Restart your terminal or run 'source ~/.zshrc' to use the tools.${NC}"
read -p "Press any key to exit script..."
