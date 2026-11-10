#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="$(dirname "$SCRIPT_DIR")"
PROJECT_DIR="$WORKSPACE_DIR/juice-shop"

ARCHIVE_URL="https://github.com/juice-shop/juice-shop/releases/download/v20.4.0/juice-shop-20.4.0_node22_linux_x64.tgz"

echo "Installation de OWASP Juice Shop 20.4.0..."

if [ ! -f "$PROJECT_DIR/package.json" ]; then
    TMP_DIR="$(mktemp -d)"
    trap 'rm -rf "$TMP_DIR"' EXIT

    echo "Téléchargement de la distribution officielle..."
    curl -fL "$ARCHIVE_URL" -o "$TMP_DIR/juice-shop.tgz"

    echo "Extraction..."
    tar -xzf "$TMP_DIR/juice-shop.tgz" -C "$TMP_DIR"

    mkdir -p "$PROJECT_DIR"
    cp -a "$TMP_DIR/juice-shop_20.4.0-SNAPSHOT/." "$PROJECT_DIR/"
fi

echo "Vérification..."
node --version
npm --version
test -f "$PROJECT_DIR/build/app.js"
test -f "$PROJECT_DIR/node_modules/express/package.json"

echo "Installation terminée."
