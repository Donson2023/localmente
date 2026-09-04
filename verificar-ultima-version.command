#!/bin/zsh
set -e

APP_DIR="/Users/mac/Projects/localmente"
cd "$APP_DIR"

git fetch origin
echo "Rama: $(git branch --show-current)"
echo "Commit local:  $(git rev-parse --short HEAD)"
echo "Último commit: $(git log -1 --format='%s (%ad)' --date=short)"
echo "Remoto main:   $(git rev-parse --short origin/main)"
echo
git status --short --branch
