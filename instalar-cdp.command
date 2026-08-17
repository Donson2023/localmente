#!/bin/bash

set -e

NODE_DIR="/Applications/ChatGPT.app/Contents/Resources/cua_node/bin"
NPX="$NODE_DIR/npx"
CODEX="/Users/mac/.local/bin/codex"

if [ ! -x "$NPX" ]; then
  echo "No encuentro Node.js incluido en ChatGPT. Instala Node.js LTS desde https://nodejs.org/"
  exit 1
fi

echo "Node disponible: $("$NODE_DIR/node" --version)"
echo "Instalando Chrome DevTools MCP desde npm..."
NPM_CONFIG_FETCH_TIMEOUT=8000 NPM_CONFIG_FETCH_RETRIES=0 "$NPX" --yes chrome-devtools-mcp@latest --help >/dev/null

echo "Registrando CDP en Codex..."
"$CODEX" mcp add chrome-devtools -- "$NPX" chrome-devtools-mcp@latest --browser-url=http://127.0.0.1:9222

echo "Listo. Reinicia Codex y ejecuta iniciar-localmente-cdp.command."
