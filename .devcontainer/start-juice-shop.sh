#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="$(dirname "$SCRIPT_DIR")"
PROJECT_DIR="$WORKSPACE_DIR/juice-shop"

if [ ! -d "$PROJECT_DIR" ]; then
    echo "ERREUR : Juice Shop n'est pas installé."
    exit 1
fi

cd "$PROJECT_DIR"

if pgrep -f "node.*build/app" >/dev/null; then
    echo "Juice Shop semble déjà démarré."
    exit 0
fi

echo "Démarrage de OWASP Juice Shop..."
nohup npm start > "$WORKSPACE_DIR/juice-shop.log" 2>&1 < /dev/null &
echo "Juice Shop lancé en arrière-plan."
