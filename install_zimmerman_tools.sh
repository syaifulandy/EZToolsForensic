#!/bin/bash
GREEN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'
ZSHRC="$HOME/.zshrc"
INSTALL_DIR="$(realpath "$(dirname "$0")")"

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

BASE_URL="https://download.ericzimmermanstools.com/net9"

clear

echo "--------------------------------------------------------------------------------------------"
echo "Installing .NET9 SDK..." 1>&2

if wget https://builds.dotnet.microsoft.com/dotnet/scripts/v1/dotnet-install.sh -O dotnet-install.sh -q && \
   chmod +x dotnet-install.sh && \
   ./dotnet-install.sh --channel 9.0 > /dev/null && \
   rm -f dotnet-install.sh && \
   grep -qxF "alias dotnet='~/.dotnet/dotnet'" "$ZSHRC" || echo "alias dotnet='~/.dotnet/dotnet'" >> "$ZSHRC"; then
    echo "${GREEN}.NET9 installed.${NC}" 1>&2
else
    echo "${RED}ERROR: Couldn't install .NET9.${NC}" 1>&2
    exit 1
fi

for tool in "${TOOLS[@]}"; do
  echo "--------------------------------------------------------------------------------------------"
  echo "Downloading ${tool}.zip..." 1>&2
  url="$BASE_URL/${tool}.zip"
  if wget "$url" -q && unzip -o "${tool}.zip" -d "${INSTALL_DIR}/${tool}" > /dev/null && rm -f "${tool}.zip"; then
    echo "${GREEN}${tool} installed successfully.${NC}" 1>&2
    alias_line="alias ${tool,,}='dotnet ${INSTALL_DIR}/${tool}/${tool}.dll'"
    grep -qxF "$alias_line" "$ZSHRC" || echo "$alias_line" >> "$ZSHRC"
  else
    echo "${RED}ERROR: Failed to install ${tool}.${NC}" 1>&2
  fi
done

echo "--------------------------------------------------------------------------------------------"
echo "${GREEN}All tools installed. Please restart your terminal or run 'source ~/.zshrc' to apply aliases.${NC}"
