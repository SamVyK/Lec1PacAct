#!/usr/bin/env bash
set -euo pipefail

FILE_PATH="${FILE:-data.txt}"
ACTOR="${GITHUB_ACTOR:-unknown}"

echo "[entrypoint] Running frequency analysis on: $FILE_PATH (actor: $ACTOR)"

FREQ_RESULT="$(python3 .github/scripts/frequency.py "$FILE_PATH")"
echo "[entrypoint] Frequency result: $FREQ_RESULT"

.github/scripts/update_readme.sh "$FREQ_RESULT" "$ACTOR"

echo "[entrypoint] Done."
