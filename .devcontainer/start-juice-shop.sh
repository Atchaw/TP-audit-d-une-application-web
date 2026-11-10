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

echo "Juice Shop lancé en arrière-plan."
