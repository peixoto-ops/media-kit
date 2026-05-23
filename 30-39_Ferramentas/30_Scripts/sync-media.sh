#!/bin/bash
# sync-media.sh — Sincroniza configurações de áudio/vídeo do SSOT para o nó local
# Uso: ./sync-media.sh [--dry]
# SSOT: ~/repos/media-kit
# Destino: ~/.config/easyeffects + ~/.config/wireplumber

set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MEDIA_KIT="$(dirname "$SCRIPT_DIR")/.."

DRY=false
[[ "$1" == "--dry" ]] && DRY=true

echo "📡 media-kit sync para $(hostname)"
echo "   SSOT: $(cd "$MEDIA_KIT" && pwd)"
echo ""

# EasyEffects presets
SRC="$MEDIA_KIT/10-19_Audio/10_EasyEffects/presets/"
DST="$HOME/.config/easyeffects/output/"
if [ -d "$SRC" ]; then
  echo "🎛️  EasyEffects presets..."
  if $DRY; then
    echo "     dry: cp $SRC*.json → $DST"
  else
    mkdir -p "$DST"
    cp "$SRC"*.json "$DST" 2>/dev/null
    echo "     ✅ $(ls "$SRC"*.json 2>/dev/null | wc -l) presets"
  fi
fi

# EasyEffects IRS
SRC="$MEDIA_KIT/10-19_Audio/10_EasyEffects/irs/"
DST="$HOME/.config/easyeffects/irs/"
if [ -d "$SRC" ]; then
  echo "📦 EasyEffects IRS..."
  if $DRY; then
    echo "     dry: cp $SRC* → $DST"
  else
    mkdir -p "$DST"
    cp "$SRC"* "$DST" 2>/dev/null
    echo "     ✅ $(ls "$SRC"* 2>/dev/null | wc -l) arquivos"
  fi
fi

# EasyEffects autoload
SRC="$MEDIA_KIT/10-19_Audio/10_EasyEffects/autoload/"
DST="$HOME/.config/easyeffects/autoload/"
if [ -d "$SRC" ]; then
  echo "🔌 EasyEffects autoload..."
  if $DRY; then
    echo "     dry: cp -r $SRC* → $DST"
  else
    mkdir -p "$DST"
    cp -r "$SRC"* "$DST" 2>/dev/null
    echo "     ✅ $(find "$SRC" -type f 2>/dev/null | wc -l) arquivos"
  fi
fi

# WirePlumber bluetooth configs
SRC="$MEDIA_KIT/10-19_Audio/11_WirePlumber/"
DST="$HOME/.config/wireplumber/bluetooth.lua.d/"
if [ -d "$SRC" ]; then
  echo "🔧 WirePlumber bluetooth..."
  if $DRY; then
    echo "     dry: cp $SRC*.lua → $DST"
  else
    mkdir -p "$DST"
    cp "$SRC"*.lua "$DST" 2>/dev/null
    echo "     ✅ $(ls "$SRC"*.lua 2>/dev/null | wc -l) configs"
    echo "     ⚠️  Reinicie WirePlumber: systemctl --user restart wireplumber"
  fi
fi

echo ""
echo "✅ Sync completo"
echo "   Reinicie EasyEffects se necessário: systemctl --user restart easyeffects"
