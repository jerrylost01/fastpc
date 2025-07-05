# Start from the official Microsoft base image for Codespaces
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Switch to the root user to install software
USER root

# Set this environment variable to prevent installers from pausing for input
ENV DEBIAN_FRONTEND=noninteractive

# --- Install ONLY the reliable packages ---
# 1. Update package lists
# 2. Install XFCE desktop and TightVNC server
# 3. Clean up the apt cache to keep the final image smaller
RUN apt-get update && \
    apt-get install -y --no-install-recommends xfce4 tightvncserver curl && \
    rm -rf /var/lib/apt/lists/*

# Switch back to the standard, non-root 'codespace' user for security
USER codespace
