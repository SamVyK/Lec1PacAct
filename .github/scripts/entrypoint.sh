#!/usr/bin/env bash
set -euo pipefail

# Inputs
FILE_PATH="${FILE:-data.txt}"
ACTOR="${GITHUB_ACTOR:-unknown}"

echo "[entrypoint] Running frequency analysis on: $FILE_PATH (actor: $ACTOR)"

# Run Python to get the frequency result (single-line JSON-ish string)
FREQ_RESULT="$(python3 .github/scripts/frequency.py "$FILE_PATH")"
echo "[entrypoint] Frequency result: $FREQ_RESULT"

# Update README with the result + actor + timestamp and commit
.github/scripts/update_readme.sh "$FREQ_RESULT" "$ACTOR"

echo "[entrypoint] Done."
