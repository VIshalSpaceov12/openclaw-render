FROM node:22-slim

# Install OpenClaw globally
RUN npm install -g openclaw

# Create data directory for persistent storage
RUN mkdir -p /data/.openclaw /data/workspace

# Set environment variables
ENV PORT=8080
ENV OPENCLAW_STATE_DIR=/data/.openclaw
ENV OPENCLAW_WORKSPACE_DIR=/data/workspace

# Expose the port
EXPOSE 8080

# Start OpenClaw gateway
CMD ["openclaw", "gateway", "start", "--port", "8080"]
