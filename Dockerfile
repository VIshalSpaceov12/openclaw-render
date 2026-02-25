FROM node:22-slim

# Install system dependencies needed for native modules
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    git \
    && rm -rf /var/lib/apt/lists/*

# Clear any stale npm cache and install OpenClaw
RUN rm -rf ~/.npm && npm install -g --ignore-scripts=false openclaw@latest

# Create data directory for persistent storage
RUN mkdir -p /data/.openclaw /data/workspace

# Set environment variables
ENV PORT=8080
ENV OPENCLAW_STATE_DIR=/data/.openclaw
ENV OPENCLAW_WORKSPACE_DIR=/data/workspace

# Expose the port
EXPOSE 8080

# Run gateway in foreground mode:
#   --dev              = create config + workspace if missing
#   --allow-unconfigured = skip gateway.mode=local requirement
#   --bind lan         = bind to 0.0.0.0 so Render can detect the port
CMD ["openclaw", "gateway", "run", "--port", "8080", "--dev", "--allow-unconfigured", "--bind", "lan", "--verbose"]
