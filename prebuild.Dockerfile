# Start from the official Microsoft base image for Codespaces
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Switch to the root user to install software
USER root

# Set this environment variable to prevent installers from pausing for input
ENV DEBIAN_FRONTEND=noninteractive

# --- Install XFCE Desktop and VNC Server ---
# 1. Update package lists
# 2. Install XFCE desktop and TightVNC server
# 3. Clean up the apt cache to keep the final image smaller
RUN apt-get update && \
    apt-get install -y --no-install-recommends xfce4 tightvncserver && \
    rm -rf /var/lib/apt/lists/*

# --- Install zrok (Robust Method) ---

# Create a temporary directory to work in
WORKDIR /tmp

# Download the zrok package to a file first (more reliable)
RUN wget -q "https://github.com/openziti/zrok/releases/latest/download/zrok_linux_amd64.tar.gz" -O zrok.tar.gz

# Extract the downloaded file
RUN tar -xzf zrok.tar.gz

# Move the zrok binary to a location in the system's PATH
RUN mv zrok /usr/local/bin/

# Clean up by going back to the root and removing the temp directory
WORKDIR /
RUN rm -rf /tmp/*


# Switch back to the standard, non-root 'codespace' user for security
USER codespace
