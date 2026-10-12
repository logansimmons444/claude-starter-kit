#!/usr/bin/env bash
# Logan's Claude starter kit. Installs the skills Logan uses most, plus a few safety guardrails.
# Safe to run more than once. Claude runs this for you; you don't need to type anything.
set -euo pipefail

KIT="$(cd "$(dirname "$0")" && pwd)"
SKILLS="$HOME/.claude/skills"
ADD="npx --yes skills@1.7.2 add"
FLAGS="-g -a claude-code -y --copy"

mkdir -p "$SKILLS"

echo "1/4  Logan's skills: opportunity, slopmonster"
for s in opportunity slopmonster; do
  rsync -a "$KIT/skills/$s/" "$SKILLS/$s/"
done
chmod +x "$SKILLS/slopmonster/tools/"*.sh 2>/dev/null || true

echo "2/4  Launch videos: brag + the Hyperframes skills it uses"
$ADD https://github.com/latent-spaces/brag --skill brag $FLAGS >/dev/null
$ADD heygen-com/hyperframes --skill hyperframes-core hyperframes-animation hyperframes-creative hyperframes-keyframes hyperframes-cli $FLAGS >/dev/null

echo "3/4  Research (last30days) + the skill builder (skill-creator)"
$ADD mvanhorn/last30days-skill --skill last30days $FLAGS >/dev/null
$ADD anthropics/skills --skill skill-creator $FLAGS >/dev/null

echo "4/4  Safety guardrails"
python3 "$KIT/settings/merge_guardrails.py"

echo
echo "Installed in $SKILLS:"
ls -1 "$SKILLS" | sed 's/^/  - /'
