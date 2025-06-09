#!/bin/bash
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

echo "Uninstalling Zimmerman tools and cleaning up .zshrc..."

for tool in "${TOOLS[@]}"; do
  echo "Removing ${INSTALL_DIR}/${tool}"
  rm -rf "${INSTALL_DIR}/${tool}"

  alias_line="alias ${tool,,}='dotnet ${INSTALL_DIR}/${tool}/${tool}.dll'"
  sed -i "\|$alias_line|d" "$ZSHRC"
done

# Optional cleanup
sed -i "/alias dotnet='~\/.dotnet\/dotnet'/d" "$ZSHRC"

echo "Done. Run 'source ~/.zshrc' or restart terminal to reflect changes."
