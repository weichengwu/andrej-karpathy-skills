# Using this repo with Codex

This project includes an [`AGENTS.md`](AGENTS.md) file so the Karpathy-inspired behavioral guidelines apply automatically when you use [OpenAI Codex CLI](https://github.com/openai/codex) in this repository. Codex reads `AGENTS.md` as its primary instruction file.

## In this repository

1. Open the folder and run Codex CLI.
2. `AGENTS.md` is automatically loaded as project-level instructions — no extra setup needed.

## Use the same guidelines in another project

**Option A: AGENTS.md (recommended)**

Copy [`AGENTS.md`](AGENTS.md) into your project root:

```bash
curl -o AGENTS.md https://raw.githubusercontent.com/forrestchang/andrej-karpathy-skills/main/AGENTS.md
```

Or append to an existing `AGENTS.md`:

```bash
echo "" >> AGENTS.md
curl https://raw.githubusercontent.com/forrestchang/andrej-karpathy-skills/main/AGENTS.md >> AGENTS.md
```

Codex supports hierarchical `AGENTS.md` files — you can place additional files in subdirectories for more specific instructions.

**Option B: Codex config fallback**

If your project already uses `CLAUDE.md`, Codex can be configured to read it as a fallback. Add to `~/.codex/config.toml`:

```toml
project_doc_fallback_filenames = ["CLAUDE.md"]
```

## How Codex loads AGENTS.md

- Codex searches from the project root (detected via `.git`) to the current working directory
- Each `AGENTS.md` governs its directory and all subdirectories
- Deeper files override conflicting instructions from parent directories
- `AGENTS.override.md` takes priority over `AGENTS.md` in the same directory

## Codex vs Claude Code vs Cursor vs OpenCode

- **Codex:** Reads `AGENTS.md` as the primary instruction file. Supports hierarchical placement.
- **OpenCode:** Reads both `AGENTS.md` and `CLAUDE.md`. Also supports skills via `SKILL.md`. See [`OPENCODE.md`](OPENCODE.md).
- **Claude Code:** Install via the plugin marketplace; see [`README.md`](README.md). Per-project use relies on `CLAUDE.md`.
- **Cursor:** Uses `.cursor/rules/` files; see [`CURSOR.md`](CURSOR.md).

## For contributors

When you change the four principles, keep **[`CLAUDE.md`](CLAUDE.md)**, **[`AGENTS.md`](AGENTS.md)**, and **[`.cursor/rules/karpathy-guidelines.mdc`](.cursor/rules/karpathy-guidelines.mdc)** in sync. If the published skill/plugin text should match, update **[`skills/karpathy-guidelines/SKILL.md`](skills/karpathy-guidelines/SKILL.md)** as well.
