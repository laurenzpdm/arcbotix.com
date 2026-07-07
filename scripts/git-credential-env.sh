#!/usr/bin/env bash
# Git credential helper for this repo: supplies the GitHub push token from
# .env instead of embedding it in .git/config or relying on gh CLI auth state.
set -euo pipefail

REPO_DIR="/home/opc/Arcbotix-Blog"
ENV_FILE="$REPO_DIR/.env"

if [ "${1:-}" != "get" ]; then
  exit 0
fi

if [ ! -f "$ENV_FILE" ]; then
  exit 0
fi

TOKEN=$(grep '^GITHUB_TOKEN=' "$ENV_FILE" | head -1 | cut -d= -f2-)

if [ -n "$TOKEN" ]; then
  echo "username=x-access-token"
  echo "password=$TOKEN"
fi
