"""Add the starter kit's guardrails to ~/.claude/settings.json without touching anything else.

Deny rules still apply in Bypass permissions mode, so these block the few commands that can
wreck a Mac or leak secrets even when Claude never asks first. Git is the real undo button;
this is the seatbelt.
"""
import json
import shutil
from pathlib import Path

DENY = [
    "Bash(sudo *)",
    "Bash(rm -rf /)",
    "Bash(rm -rf /*)",
    "Bash(rm -rf ~)",
    "Bash(rm -rf ~/*)",
    "Bash(rm -rf $HOME*)",
    "Bash(git push --force*)",
    "Bash(git push -f*)",
    "Bash(diskutil *)",
    "Read(~/.ssh/**)",
    "Read(~/Library/Keychains/**)",
]

path = Path.home() / ".claude" / "settings.json"
path.parent.mkdir(parents=True, exist_ok=True)
settings = {}
if path.exists():
    try:
        settings = json.loads(path.read_text() or "{}")
    except json.JSONDecodeError:
        print(f"  settings.json isn't valid JSON, left it alone: {path}")
        raise SystemExit(0)
    shutil.copy(path, path.with_name("settings.json.before-starter-kit"))

perms = settings.setdefault("permissions", {})
deny = perms.setdefault("deny", [])
added = [rule for rule in DENY if rule not in deny]
deny.extend(added)
path.write_text(json.dumps(settings, indent=2) + "\n")
print(f"  {len(added)} guardrails added ({len(deny)} total) in {path}")
