FROM ghcr.io/tophyr/tinkerbuild:2026-03-09

# Base image runs as non-root (ubuntu); switch to root only for global install.
USER root
RUN npm install -g @openai/codex

# Return to non-root user from the base image.
USER ubuntu
WORKDIR /workspace

CMD ["codex", "--help"]
