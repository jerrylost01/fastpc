#!/bin/bash
echo "------------------------------------------------------------"
echo "        VNC Desktop with zrok - Startup Script"
echo "------------------------------------------------------------"
if ! zrok status &>/dev/null; then
    echo "zrok is not configured. Please provide your token."
    read -p "Paste your zrok token here and press Enter: " ZROK_TOKEN_INPUT
    if [ -z "$ZROK_TOKEN_INPUT" ]; then
        echo "No token provided. Exiting."
        sleep infinity
        exit 1
    fi
    echo "--- Enabling zrok... ---"
    zrok enable "$ZROK_TOKEN_INPUT"
else
    echo "--- zrok is already enabled. Skipping setup. ---"
fi
echo "--- Starting VNC Server in the background ---"
vncserver -localhost no -geometry 1280x720 :1 &
sleep 2
echo "--- Creating public zrok share ---"
zrok share public --backend-mode tcpTunnel vnc://127.0.0.1:5901
