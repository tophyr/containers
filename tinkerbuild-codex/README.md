# tinkerbuild-codex

This image extends `ghcr.io/tophyr/tinkerbuild:2026-03-09` and installs the OpenAI Codex CLI.

## Secrets model

- Do not bake any API key/token into `Dockerfile`.
- Reuse local Codex login by mounting host `~/.codex` into container.
- Keep local path config in `.env` (ignored by git).

## Setup

1. Copy `.env.example` to `.env` and set values for your machine.
2. Keep `.env` private (already in `.gitignore`).

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

