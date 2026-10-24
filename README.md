# Claude starter kit

The skills I use most in Claude Code, packed up for friends. Goes with the guide at
**https://start-here-logan.vercel.app**.

## Install

You don't type anything. In the Claude desktop app's Code tab, paste this:

> Install Logan's starter kit: clone https://github.com/logansimmons444/claude-starter-kit into ~/claude-starter-kit (or pull it if it's already there) and run its install.sh. Then tell me in 3 short lines what got installed.

## What's inside

| Skill | What it does | From |
|---|---|---|
| opportunity | Pressure-tests an idea: why now, who's done it, the sharper version, GO / BEND / KILL | Logan (MIT) |
| slopmonster | Makes AI-written copy read human. Lint, rewrite, cleanse with a rival model, lint again | [Jack Roberts](https://github.com/ItsssssJack/SlopMonster) (MIT). One change here: the cleanse step uses the free Gemini CLI when Codex isn't installed |
| brag | Turns a project into a short launch video | [latent-spaces/brag](https://github.com/latent-spaces/brag), installed from upstream |
| hyperframes, hyperframes-cli, hyperframes-registry, media-use | The video engine brag uses (the four "core" Hyperframes skills; renamed upstream on 2026-10-21) | [heygen-com/hyperframes](https://github.com/heygen-com/hyperframes), installed from upstream |
| last30days | What people are actually saying about a topic in the last 30 days | [mvanhorn/last30days-skill](https://github.com/mvanhorn/last30days-skill), installed from upstream |
| skill-creator | Teach Claude a new move and save it as your own skill | [anthropics/skills](https://github.com/anthropics/skills), installed from upstream |

Also:
- `settings/merge_guardrails.py` adds a short deny list to `~/.claude/settings.json` (no `sudo`, no wiping your home folder, no reading your SSH keys). These rules still apply in Bypass permissions mode. Your old file is saved next to it as `settings.json.before-starter-kit`.
- `templates/CLAUDE.md` is the starting point for your own about-me file. The interview in the guide fills it in.

## Costs

Everything here is free. Running it needs Claude Pro ($20/mo) and nothing else.
