#!/usr/bin/env bash
set -euo pipefail

docker compose down

cd "$(dirname "${BASH_SOURCE[0]}")"

find "$dir" -mindepth 1 ! -name '.gitkeep' -exec rm -rf {} +

echo "Done."