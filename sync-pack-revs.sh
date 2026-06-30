#!/usr/bin/env bash
set -euo pipefail

NIX_LOCK="nix-nvim-pack-lock.json"
PACK_LOCK="nvim-pack-lock.json"

if [[ ! -f "$NIX_LOCK" || ! -f "$PACK_LOCK" ]]; then
  echo "Error: must be run from the nvim config directory" >&2
  exit 1
fi

updated=0
result=$(cat "$NIX_LOCK")

while IFS= read -r plugin; do
  old_rev=$(jq -r --arg p "$plugin" '.plugins[$p].rev' "$NIX_LOCK")
  new_rev=$(jq -r --arg p "$plugin" '.plugins[$p].rev' "$PACK_LOCK")

  if [[ "$old_rev" == "$new_rev" ]]; then
    continue
  fi

  src=$(jq -r --arg p "$plugin" '.plugins[$p].src' "$NIX_LOCK")
  if [[ -z "$src" || "$src" == "null" ]]; then
    echo "Error: .src missing for $plugin in $NIX_LOCK" >&2
    exit 1
  fi
  tarball="${src}/archive/${new_rev}.tar.gz"
  echo "Updating $plugin: ${old_rev:0:8} -> ${new_rev:0:8}"
  echo "  Fetching hash from $tarball ..."
  hash=$(nix store prefetch-file --json --unpack "$tarball" | jq -r '.hash')
  result=$(echo "$result" | jq \
    --arg p "$plugin" --arg r "$new_rev" --arg h "$hash" \
    '.plugins[$p].rev = $r | .plugins[$p].hash = $h')
  updated=$((updated + 1))
done < <(jq -r '.plugins | keys[]' "$NIX_LOCK" | while read -r p; do
  jq -e --arg p "$p" '.plugins[$p]' "$PACK_LOCK" > /dev/null 2>&1 && echo "$p"
done)

echo "$result" > "$NIX_LOCK"

if [[ $updated -eq 0 ]]; then
  echo "All revs already in sync."
else
  echo "$updated plugin(s) updated."
fi
