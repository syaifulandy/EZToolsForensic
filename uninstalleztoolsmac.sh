#!/bin/bash
GREEN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'

echo "--------------------------------------------------------------------------------------------"
echo "Uninstalling Eric Zimmerman's tools and .NET 9..." 1>&2

INSTALL_DIR="$HOME"
DOTNET_DIR="$INSTALL_DIR/dotnet"
ZSHRC="$HOME/.zshrc"

# Daftar tool
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

# Hapus tools jika ada
for tool in "${TOOLS[@]}"; do
  TOOL_PATH="$INSTALL_DIR/$tool"
  if [[ -d "$TOOL_PATH" ]]; then
    rm -rf "$TOOL_PATH"
    echo "${GREEN}Removed: $tool${NC}"
  else
    echo "${RED}Not found: $tool (skip)${NC}"
  fi
done

# Hapus .NET 9 jika ada
if [[ -d "$DOTNET_DIR" ]]; then
  rm -rf "$DOTNET_DIR"
  echo "${GREEN}Removed: .NET 9 directory${NC}"
else
  echo "${RED}.NET 9 directory not found (skip)${NC}"
fi

# Bersihkan .zshrc jika ada
if [[ -f "$ZSHRC" ]]; then
  echo "Updating $ZSHRC..."
  sed -i '/alias dotnet=/d' "$ZSHRC"
  sed -i '/export PATH=.*\/dotnet/d' "$ZSHRC"

  for tool in "${TOOLS[@]}"; do
    alias_name="${tool,,}"
    sed -i "/alias ${alias_name}=/d" "$ZSHRC"
  done
  echo "${GREEN}.zshrc cleaned.${NC}"
else
  echo "${RED}.zshrc not found. Skipping shell cleanup.${NC}"
fi

echo "--------------------------------------------------------------------------------------------"
echo "${GREEN}Uninstallation complete. Restart your terminal or run 'source ~/.zshrc'.${NC}"
read -p "Press any key to exit script..."
