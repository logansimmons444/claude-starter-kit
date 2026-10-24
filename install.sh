#!/usr/bin/env bash
# Logan's Claude starter kit. Installs the skills Logan uses most, plus a few safety guardrails.
# Safe to run more than once. Claude runs this for you; you don't need to type anything.
set -euo pipefail

KIT="$(cd "$(dirname "$0")" && pwd)"
SKILLS="$HOME/.claude/skills"
ADD="npx --yes skills@1.7.2 add"
FLAGS="-g -a claude-code -y --copy"

# The Hyperframes skills brag reads. heygen-com/hyperframes renamed its skills on 2026-10-21
# (the old hyperframes-core / -animation / -creative / -keyframes are gone). If this list ever
# goes stale again, the check at the bottom says so instead of finishing quietly.
HF_SKILLS="hyperframes hyperframes-cli hyperframes-registry media-use"

mkdir -p "$SKILLS"

echo "1/4  Logan's skills: opportunity, slopmonster"
for s in opportunity slopmonster; do
  rsync -a "$KIT/skills/$s/" "$SKILLS/$s/"
done
chmod +x "$SKILLS/slopmonster/tools/"*.sh 2>/dev/null || true

echo "2/4  Launch videos: brag + the Hyperframes skills it uses"
$ADD https://github.com/latent-spaces/brag --skill brag $FLAGS >/dev/null
# shellcheck disable=SC2086
$ADD heygen-com/hyperframes --skill $HF_SKILLS $FLAGS >/dev/null

echo "3/4  Research (last30days) + the skill builder (skill-creator)"
$ADD mvanhorn/last30days-skill --skill last30days $FLAGS >/dev/null
$ADD anthropics/skills --skill skill-creator $FLAGS >/dev/null

echo "4/4  Safety guardrails"
python3 "$KIT/settings/merge_guardrails.py"

echo
echo "Installed in $SKILLS:"
ls -1 "$SKILLS" | sed 's/^/  - /'

# Make sure everything we asked for actually landed. `skills add` skips names it can't find
# without failing, so a renamed upstream skill would otherwise slip through unnoticed.
MISSING=""
for s in opportunity slopmonster brag $HF_SKILLS last30days skill-creator; do
  [ -f "$SKILLS/$s/SKILL.md" ] || MISSING="$MISSING $s"
done
if [ -n "$MISSING" ]; then
  echo
  echo "PROBLEM: these skills did not install:$MISSING" >&2
  echo "An upstream repo probably renamed them. Check https://github.com/heygen-com/hyperframes/tree/main/skills" >&2
  echo "and tell Logan so he can update the kit." >&2
  exit 1
fi
echo
echo "All $(echo opportunity slopmonster brag $HF_SKILLS last30days skill-creator | wc -w | tr -d ' ') skills present."
