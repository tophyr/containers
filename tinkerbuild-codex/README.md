# tinkerbuild-codex

This image extends `ghcr.io/tophyr/tinkerbuild:2026-03-09-r1` and installs the OpenAI Codex CLI.

## Secrets model

- Do not bake any API key/token into `Dockerfile`.
- Bind-mount the host `~/.codex` directory into `/root/.codex`.

## Setup

```bash
test -f ~/.codex/auth.json
test -f ~/.codex/config.toml
```

## Build

```bash
docker build -t ghcr.io/tophyr/tinkerbuild-codex:2026-03-09-r1 tinkerbuild-codex
```

## Run

```bash
cd tinkerbuild-codex
docker compose run --rm codex
```

This launches `codex` inside the container using your existing host login state from `~/.codex/auth.json`.

The container now runs as `root`, so both the workspace bind mount and the host `~/.codex` bind mount are writable inside the container under rootless Docker.
