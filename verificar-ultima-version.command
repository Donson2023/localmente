#!/bin/zsh
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
APP_DIR="$SCRIPT_DIR"
cd "$APP_DIR"

git fetch origin
echo "Rama: $(git branch --show-current)"
echo "Commit local:  $(git rev-parse --short HEAD)"
echo "Último commit: $(git log -1 --format='%s (%ad)' --date=short)"
echo "Remoto main:   $(git rev-parse --short origin/main)"
echo
git status --short --branch
