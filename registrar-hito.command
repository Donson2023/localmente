#!/bin/zsh
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
APP_DIR="$SCRIPT_DIR"
cd "$APP_DIR"

if [[ -z "$1" ]]; then
  echo "Uso: ./registrar-hito.command \"Descripción breve del avance\""
  exit 1
fi

STAMP=$(date '+%Y-%m-%d %H:%M %z')
MESSAGE="$*"
printf '| %s | pendiente | %s |\n' "$STAMP" "$MESSAGE" >> HITOS.md
git add -u
git add HITOS.md
git commit -m "hito: $MESSAGE"
COMMIT=$(git rev-parse --short HEAD)
sed -i '' "s/| $STAMP | pendiente |/| $STAMP | $COMMIT |/" HITOS.md
git add HITOS.md
git commit -m "meta: identify hito $COMMIT"
git push origin main
echo "Hito publicado: $COMMIT — $MESSAGE"
