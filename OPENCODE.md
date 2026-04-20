# Using this repo with OpenCode

This project includes an [`AGENTS.md`](AGENTS.md) file so the Karpathy-inspired behavioral guidelines apply automatically when you use [OpenCode](https://opencode.ai) in this repository. OpenCode reads `AGENTS.md` (and `CLAUDE.md`) as instruction files.

## In this repository

1. Open the folder in OpenCode.
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

**Option B: OpenCode Skill**

Copy the [`skills/karpathy-guidelines/`](skills/karpathy-guidelines/) directory into your OpenCode skills folder:

```bash
# Global skill (available in all projects)
mkdir -p ~/.config/opencode/skills
cp -r skills/karpathy-guidelines ~/.config/opencode/skills/

# Or project-level skill
mkdir -p .opencode/skills
cp -r skills/karpathy-guidelines .opencode/skills/
```

The skill can then be invoked via the `skill` tool with `name: karpathy-guidelines`.

## OpenCode vs Claude Code vs Cursor

- **OpenCode:** Reads `AGENTS.md` and `CLAUDE.md` as instruction files. Also supports skills via `SKILL.md`.
- **Claude Code:** Install via the plugin marketplace; see [`README.md`](README.md). Per-project use relies on `CLAUDE.md`.
- **Cursor:** Uses `.cursor/rules/` files; see [`CURSOR.md`](CURSOR.md).

## For contributors

When you change the four principles, keep **[`CLAUDE.md`](CLAUDE.md)**, **[`AGENTS.md`](AGENTS.md)**, and **[`.cursor/rules/karpathy-guidelines.mdc`](.cursor/rules/karpathy-guidelines.mdc)** in sync. If the published skill/plugin text should match, update **[`skills/karpathy-guidelines/SKILL.md`](skills/karpathy-guidelines/SKILL.md)** as well.
