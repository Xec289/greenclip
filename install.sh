#!/usr/bin/env bash
set -e

VERSION="v4.2"
TMP_FILE="/tmp/greenclip"
BIN_PATH="/usr/local/bin/greenclip"
USER_SERVICE_DIR="$HOME/.config/systemd/user"
SERVICE_PATH="$USER_SERVICE_DIR/greenclip.service"

echo "[+] Downloading greenclip ${VERSION}..."
wget -q "https://github.com/erebe/greenclip/releases/download/${VERSION}/greenclip" -O "$TMP_FILE"

echo "[+] Installing binary..."
chmod +x "$TMP_FILE"
sudo mv "$TMP_FILE" "$BIN_PATH"

echo "[+] Creating user systemd service..."
mkdir -p "$USER_SERVICE_DIR"

cat > "$SERVICE_PATH" <<EOF
[Unit]
Description=Greenclip Clipboard Manager
After=graphical-session.target

[Service]
Type=simple
ExecStart=$BIN_PATH daemon
Restart=always
RestartSec=3

[Install]
WantedBy=default.target
EOF

echo "[+] Reloading user systemd..."
systemctl --user daemon-reload

echo "[+] Enabling greenclip user service..."
systemctl --user enable greenclip.service

echo "[+] Starting greenclip..."
systemctl --user start greenclip.service

echo "[+] Service status:"
systemctl --user status greenclip.service --no-pager
