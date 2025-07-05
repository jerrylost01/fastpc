#!/bin/bash

# --- Check if zrok command exists ---
if ! command -v zrok &> /dev/null
then
    # If zrok is NOT found, print instructions and stop.
    echo "------------------------------------------------------------------"
    echo "### WELCOME! First-time setup required. ###"
    echo ""
    echo "zrok is not installed. Please install it by running this command:"
    echo ""
    echo "--- Copy the command below and paste it into this terminal ---"
    echo ""
    # This command is robust and easy to copy.
    echo 'curl -sSL "https://github.com/openziti/zrok/releases/latest/download/zrok_linux_amd64.tar.gz" | sudo tar -xz -C /usr/local/bin'
    echo ""
    echo "------------------------------------------------------------------"
    echo "After the command finishes, RESTART this Codespace to continue."
    echo "You can do this by clicking the green '><' icon in the bottom-left,"
    echo "and choosing 'Restart Codespace'."
    echo "------------------------------------------------------------------"
    # Keep the terminal open so the user can see the message.
    sleep infinity
    exit
fi

# --- If we get here, zrok IS installed. Proceed as normal. ---

echo "------------------------------------------------------------"
echo "        VNC Desktop with zrok - Startup Script"
echo "------------------------------------------------------------"

# Check if zrok is already enabled for this Codespace
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
echo ""
echo "Your public VNC connection details will appear below."
echo "------------------------------------------------------------"
zrok share public --backend-mode tcpTunnel vnc://127.0.0.1:5901
