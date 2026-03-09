# tinkerbuild-codex

This image extends `ghcr.io/tophyr/tinkerbuild:2026-03-09` and installs the OpenAI Codex CLI.

## Secrets model

- Do not bake any API key/token into `Dockerfile`.
- Use the local Docker volume `codex_state` for Codex auth/config state.
- Seed that volume from your host login files with `scripts/init-codex-volume.sh`.

## Setup

```bash
scripts/init-codex-volume.sh
```

## Build

```bash
docker build -t ghcr.io/tophyr/tinkerbuild-codex:2026-03-09 tinkerbuild-codex
```

## Run

```bash
cd tinkerbuild-codex
docker compose run --rm codex
```

This launches `codex` inside the container using your existing host login state from `~/.codex/auth.json`.
