---
"mattpocock-skills": minor
---

Add `agents/` — two Claude Code subagents shipped with the plugin.

- `matt-pocock-router` — points at the right `/skill-name` for a fuzzy "what do I do next" question; never executes a skill itself, since most of the main-flow skills are user-invoked only.
- `matt-pocock-implementer` — takes a scoped chunk of engineering work and drives it with `/tdd`, `/domain-modeling`, `/codebase-design`, and `/code-review` in its own context window.

Wired into `.claude-plugin/plugin.json`'s new `agents` array, documented in `CLAUDE.md`/`AGENTS.md` and the top-level `README.md`, and linked locally via the new `scripts/link-agents.sh` (mirrors `scripts/link-skills.sh`, into `~/.claude/agents`).
