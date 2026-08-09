#!/usr/bin/env bash
set -euo pipefail

# NOTE: This is a dev-only script, intended for use by maintainers of this repo.
# It is not a supported installer.
#
# Links every subagent in agents/ into the local Claude Code subagent directory:
#   - ~/.claude/agents — Claude Code
# Each entry is a symlink into this repo, so a `git pull` is all that's needed
# to keep installed agents up to date. Run alongside scripts/link-skills.sh —
# it does not touch that script or its destinations.

REPO="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$HOME/.claude/agents"

# If $DEST is a symlink that resolves into this repo, we'd end up writing the
# per-agent symlinks back into the repo's own agents/ tree. Detect and bail
# out instead of polluting the working copy.
if [ -L "$DEST" ]; then
  resolved="$(readlink -f "$DEST")"
  case "$resolved" in
    "$REPO"|"$REPO"/*)
      echo "error: $DEST is a symlink into this repo ($resolved)." >&2
      echo "Remove it (rm \"$DEST\") and re-run; the script will recreate it as a real dir." >&2
      exit 1
      ;;
  esac
fi

mkdir -p "$DEST"

for agent_md in "$REPO"/agents/*.md; do
  name="$(basename "$agent_md")"
  target="$DEST/$name"

  if [ -e "$target" ] && [ ! -L "$target" ]; then
    rm -f "$target"
  fi

  ln -sfn "$agent_md" "$target"
  echo "linked $name -> $agent_md ($DEST)"
done
