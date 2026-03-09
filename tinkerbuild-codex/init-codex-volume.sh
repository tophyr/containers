#!/usr/bin/env bash
set -euo pipefail

VOLUME_NAME="${VOLUME_NAME:-codex_state}"
SOURCE_DIR="${SOURCE_DIR:-$HOME/.codex}"
IMAGE_NAME="${IMAGE_NAME:-ghcr.io/tophyr/tinkerbuild-codex:2026-03-09}"

usage() {
  cat <<'EOF'
Initialize a local Docker volume with Codex auth/config files.

Usage:
  scripts/init-codex-volume.sh [--volume NAME] [--source DIR] [--image IMAGE]

Environment overrides:
  VOLUME_NAME   Default: codex_state
  SOURCE_DIR    Default: $HOME/.codex
  IMAGE_NAME    Default: ghcr.io/tophyr/tinkerbuild-codex:2026-03-09
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --volume)
      VOLUME_NAME="$2"
      shift 2
      ;;
    --source)
      SOURCE_DIR="$2"
      shift 2
      ;;
    --image)
      IMAGE_NAME="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if [[ ! -f "$SOURCE_DIR/auth.json" ]]; then
  echo "Missing source file: $SOURCE_DIR/auth.json" >&2
  exit 1
fi

if [[ ! -f "$SOURCE_DIR/config.toml" ]]; then
  echo "Missing source file: $SOURCE_DIR/config.toml" >&2
  exit 1
fi

docker volume create "$VOLUME_NAME" >/dev/null

docker run --rm \
  --user 0:0 \
  -v "$VOLUME_NAME:/dst" \
  -v "$SOURCE_DIR:/src:ro" \
  "$IMAGE_NAME" \
  sh -lc 'cp /src/auth.json /dst/auth.json && cp /src/config.toml /dst/config.toml && chown -R 1000:1000 /dst && find /dst -type d -exec chmod u+rwx,go-rwx {} + && find /dst -type f -exec chmod u+rw,go-rwx {} +'

echo "Initialized volume '$VOLUME_NAME' from '$SOURCE_DIR'."
