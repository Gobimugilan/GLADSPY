#!/bin/bash

FLASK_FILE="app.py"
PORT="5000"
TUNNEL_LOG="tunnel.log"
TUNNEL_PID=""
FLASK_PID=""

run_flask() {
  echo "[+] Starting Flask on http://127.0.0.1:$PORT ..."
  python3 $FLASK_FILE > /dev/null 2>&1 &
  FLASK_PID=$!
  sleep 3
}

start_cloudflare() {
  echo "[+] Starting Cloudflare Tunnel ..."
  cloudflared tunnel --url http://127.0.0.1:$PORT > $TUNNEL_LOG 2>&1 &
  TUNNEL_PID=$!

  # Try to find tunnel URL (wait max 15 seconds)
  echo "[*] Waiting for public URL..."
  for i in {1..15}; do
    LINK=$(grep -o 'https://[a-zA-Z0-9.-]*\.trycloudflare\.com' $TUNNEL_LOG | head -1)
    if [ ! -z "$LINK" ]; then
      echo "[+] Public URL: $LINK"
      break
    fi
    sleep 1
  done

  if [ -z "$LINK" ]; then
    echo "[!] Could not retrieve public URL from Cloudflare Tunnel logs."
    echo "[!] No public URL available."
  fi
}

# UI
echo "============================================"
echo  "  ____ _        _    ____  ____  ______   __"
echo  " / ___| |      / \  |  _ \/ ___||  _ \ \ / /"
echo  "| |  _| |     / _ \ | | | \___ \| |_) \ V /"
echo  "| |_| | |___ / |_| \| |_| |___) |  __/ | |"
echo  " \____|_____/_/   \_\____/|____/|_|    |_|"
echo "==========================================="
echo "Follow Me On Instagram:_gobinathan_"
echo "==========================================="
echo "1. Run locally (127.0.0.1)"
echo "2. Make it public with Cloudflare Tunnel"
read -p "Choose an option (1 or 2): " option

if [[ "$option" == "1" ]]; then
  run_flask
  echo "[✔] Flask running locally at http://127.0.0.1:$PORT"
elif [[ "$option" == "2" ]]; then
  run_flask
  start_cloudflare
else
  echo "[!] Invalid option. Exiting."
  exit 1
fi

# Wait for user
read -p "Press ENTER to stop everything..."

# Cleanup
echo "[✖] Stopping services..."
kill $FLASK_PID 2>/dev/null
if [[ ! -z "$TUNNEL_PID" ]]; then
  kill $TUNNEL_PID 2>/dev/null
fi
rm -f $TUNNEL_LOG
echo "[✔] Everything stopped. Interface complete."

