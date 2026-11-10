#!/usr/bin/env bash
set -euo pipefail

echo "========================================"
echo " Installation de OWASP Juice Shop 20.4.0"
echo "========================================"

PROJECT_DIR="/workspaces/$(basename "$PWD")/juice-shop"

if [ -d "$PROJECT_DIR" ]; then
    echo "Le dossier Juice Shop existe déjà."
else
    echo "Téléchargement de Juice Shop..."
    git clone --depth 1 --branch v20.4.0 \
        https://github.com/juice-shop/juice-shop.git \
        "$PROJECT_DIR"
fi

cd "$PROJECT_DIR"

echo "Installation des dépendances Node.js..."
CYPRESS_INSTALL_BINARY=0 npm install

echo "========================================"
echo " Installation terminée avec succès."
echo "========================================"
