#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="/workspaces/$(basename "$PWD")/juice-shop"
ARCHIVE_URL="https://github.com/juice-shop/juice-shop/releases/download/v20.4.0/juice-shop-20.4.0_node22_linux_x64.tgz"

echo "Installation de OWASP Juice Shop 20.4.0..."

mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

if [ ! -f package.json ]; then
    echo "Téléchargement de la distribution officielle..."
    curl -fL "$ARCHIVE_URL" -o /tmp/juice-shop.tgz

    echo "Extraction..."
    tar -xzf /tmp/juice-shop.tgz -C "$PROJECT_DIR"

    rm /tmp/juice-shop.tgz
fi

echo "Vérification de l'installation..."
node --version
npm --version

echo "Installation terminée."
