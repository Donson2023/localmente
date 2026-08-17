#!/bin/bash

APP_DIR="/Users/mac/localmente-webapp"
PORT="3000"
CDP_PORT="9222"
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
PROFILE_DIR="/tmp/localmente-chrome-profile"

cd "$APP_DIR" || exit 1
python3 -m http.server "$PORT" --bind 127.0.0.1 --directory "$APP_DIR" &
SERVER_PID=$!
sleep 1

if [ -x "$CHROME" ]; then
  "$CHROME" --remote-debugging-port="$CDP_PORT" --user-data-dir="$PROFILE_DIR" "http://127.0.0.1:${PORT}" &
else
  open -a "Google Chrome" "http://127.0.0.1:${PORT}"
  echo "Chrome no está en la ruta estándar; inicia CDP manualmente con el comando de la guía."
fi

echo "Webapp: http://127.0.0.1:${PORT}"
echo "CDP:    http://127.0.0.1:${CDP_PORT}"
echo "No cierres esta ventana mientras estés probando."
wait "$SERVER_PID"
