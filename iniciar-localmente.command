#!/bin/bash

APP_DIR="/Users/mac/localmente-webapp"
PORT="3000"

cd "$APP_DIR" || exit 1

echo "Localmente está disponible en http://localhost:${PORT}"
python3 -m http.server "$PORT" --bind 127.0.0.1 --directory "$APP_DIR" &
SERVER_PID=$!
sleep 1
open -a "Google Chrome" "http://localhost:${PORT}"
echo "No cierres esta ventana mientras estés usando la webapp."
echo ""
wait "$SERVER_PID"
