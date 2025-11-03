#!/usr/bin/env bash
set -euo pipefail

FREQ_RESULT="${1:-}"
GITHUB_USER="${2:-unknown}"
TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"

if [[ -z "$FREQ_RESULT" ]]; then
  echo "[update_readme] No frequency result supplied." >&2
  exit 3
fi

[[ -f README.md ]] || echo "# Vowel Frequency Log" > README.md

{
  echo ""
  echo "### Update by ${GITHUB_USER} on ${TIMESTAMP}"
  echo "- Result: \`${FREQ_RESULT}\`"
} >> README.md

git config --global user.name  "github-actions[bot]"
git config --global user.email "github-actions[bot]@users.noreply.github.com"

if ! git diff --quiet; then
  git add README.md
  git commit -m "ci: update README with vowel frequency (${GITHUB_USER})"
fi
