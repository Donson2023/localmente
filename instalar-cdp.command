#!/bin/bash

set -e

NODE_DIR="${NODE_DIR:-}"
if [ -z "$NODE_DIR" ] || [ ! -x "$NODE_DIR/npx" ]; then
  NODE_DIR="$(dirname "$(command -v npx 2>/dev/null || true)")"
fi
NPX="$NODE_DIR/npx"
CODEX="$(command -v codex 2>/dev/null || true)"

if [ ! -x "$NPX" ]; then
  echo "No encuentro npx. Instala Node.js LTS desde https://nodejs.org/"
  exit 1
fi

if [ -z "$CODEX" ]; then
  echo "No encuentro el comando codex en este dispositivo. Instálalo o registra el MCP manualmente."
  exit 1
fi

echo "Node disponible: $("$NODE_DIR/node" --version)"
echo "Instalando Chrome DevTools MCP desde npm..."
NPM_CONFIG_FETCH_TIMEOUT=8000 NPM_CONFIG_FETCH_RETRIES=0 "$NPX" --yes chrome-devtools-mcp@latest --help >/dev/null

echo "Registrando CDP en Codex..."
"$CODEX" mcp add chrome-devtools -- "$NPX" chrome-devtools-mcp@latest --browser-url=http://127.0.0.1:9222

echo "Listo. Reinicia Codex y ejecuta iniciar-localmente-cdp.command."
