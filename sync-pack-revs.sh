#!/usr/bin/env bash
set -euo pipefail

NIX_LOCK="nix-nvim-pack-lock.json"
PACK_LOCK="nvim-pack-lock.json"

if [[ ! -f $NIX_LOCK || ! -f $PACK_LOCK ]]; then
  echo "Error: must be run from the nvim config directory" >&2
  exit 1
fi

updated=0

new_json=$(jq --slurpfile pack "$PACK_LOCK" '
  .plugins |= with_entries(
    if $pack[0].plugins[.key] then
      .value.rev = $pack[0].plugins[.key].rev
    else
      .
    end
  )
' "$NIX_LOCK")

# Report what changed
while IFS= read -r plugin; do
  old_rev=$(jq -r --arg p "$plugin" '.plugins[$p].rev' "$NIX_LOCK")
  new_rev=$(jq -r --arg p "$plugin" '.plugins[$p].rev' "$PACK_LOCK")
  if [[ $old_rev != "$new_rev" ]]; then
    echo "Updated $plugin: ${old_rev:0:8} -> ${new_rev:0:8}"
    updated=$((updated + 1))
  fi
  echo "$updated"
done < <(jq -r '.plugins | keys[]' "$NIX_LOCK" | while read -r p; do
  jq -e --arg p "$p" '.plugins[$p]' "$PACK_LOCK" > /dev/null 2>&1 && echo "$p"
done)

echo "$new_json" > "$NIX_LOCK"

if [[ $updated -eq 0 ]]; then
  echo "All revs already in sync."
else
  echo "$updated plugin(s) updated."
fi
