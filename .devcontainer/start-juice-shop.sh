#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="$(dirname "$SCRIPT_DIR")"
PROJECT_DIR="$WORKSPACE_DIR/juice-shop"
LOG_FILE="$WORKSPACE_DIR/juice-shop.log"

if [ ! -f "$PROJECT_DIR/build/app.js" ]; then
    echo "ERREUR : Juice Shop n'est pas installé correctement."
    exit 1
fi

cd "$PROJECT_DIR"

if curl -fsS http://127.0.0.1:3000/ >/dev/null 2>&1; then
    echo "Juice Shop est déjà accessible."
    exit 0
fi

echo "Démarrage de OWASP Juice Shop..."

nohup npm start > "$LOG_FILE" 2>&1 < /dev/null &
SERVER_PID=$!

echo "Attente du démarrage de Juice Shop..."

for attempt in {1..30}; do
    if curl -fsS http://127.0.0.1:3000/ >/dev/null 2>&1; then
        echo "Juice Shop est accessible sur le port 3000."
        exit 0
    fi

    if ! kill -0 "$SERVER_PID" 2>/dev/null; then
        echo "ERREUR : le processus Juice Shop s'est arrêté."
        cat "$LOG_FILE"
        exit 1
    fi

    sleep 1
done

echo "ERREUR : Juice Shop ne répond pas après 30 secondes."
cat "$LOG_FILE"
exit 1