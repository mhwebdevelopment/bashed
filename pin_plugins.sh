#!/usr/bin/env bash
set -euo pipefail

BASE="${1:-$HOME/.local/share/nvim/site/pack/plugins/start}"
OUT="${2:-./plugins_pinned.csv}"

# Resolve OUT to an absolute path before we start cd'ing around
OUT="$(readlink -f "$OUT")"

if [ ! -d "$BASE" ]; then
  echo "Base directory does not exist: $BASE" >&2
  exit 1
fi

echo "plugin,hash,date,note" > "$OUT"

for dir in "$BASE"/*; do
  if [ ! -d "$dir/.git" ]; then
    continue
  fi

  plugin="$(basename "$dir")"
  cd "$dir"

  line="$(git log -1 --pretty=format:'%H|%cI|%s')"
  hash="${line%%|*}"
  rest="${line#*|}"
  date="${rest%%|*}"
  note="${rest#*|}"

  git checkout "$hash" >/dev/null 2>&1
  echo "pinned $plugin -> $hash"

  safe_note="${note//\"/\"\"}"
  echo "$plugin,$hash,$date,\"$safe_note\"" >> "$OUT"
done

echo "CSV written to $OUT"