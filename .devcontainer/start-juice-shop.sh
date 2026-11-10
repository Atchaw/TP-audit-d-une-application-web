#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="/workspaces/$(basename "$PWD")/juice-shop"

if [ ! -d "$PROJECT_DIR" ]; then
    echo "ERREUR : Juice Shop n'est pas installé."
    echo "Vérifie le script setup.sh."
    exit 1
fi

cd "$PROJECT_DIR"

echo "Démarrage de OWASP Juice Shop..."
npm start
