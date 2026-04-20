#!/usr/bin/env bash
set -euo pipefail

# Karpathy Guidelines Installer
# Installs behavioral guidelines for AI coding assistants.
# Supports: Claude Code, Cursor, OpenCode, Codex

REPO_RAW="https://raw.githubusercontent.com/forrestchang/andrej-karpathy-skills/main"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

info()  { printf "${BLUE}▸${NC} %s\n" "$1"; }
ok()    { printf "${GREEN}✓${NC} %s\n" "$1"; }
warn()  { printf "${YELLOW}!${NC} %s\n" "$1"; }
err()   { printf "${RED}✗${NC} %s\n" "$1" >&2; }

download() {
  local url="$1" dest="$2"
  if command -v curl &>/dev/null; then
    curl -fsSL "$url" -o "$dest"
  elif command -v wget &>/dev/null; then
    wget -qO "$dest" "$url"
  else
    err "Neither curl nor wget found. Please install one."
    exit 1
  fi
}

install_file() {
  local url="$1" dest="$2" name="$3"
  if [[ -f "$dest" ]]; then
    printf "  ${YELLOW}%s already exists.${NC} " "$dest"
    printf "[${BOLD}o${NC}]verwrite / [${BOLD}a${NC}]ppend / [${BOLD}s${NC}]kip? "
    read -r choice
    case "$choice" in
      o|O)
        download "$url" "$dest"
        ok "Overwritten $dest"
        ;;
      a|A)
        printf "\n" >> "$dest"
        download "$url" "/tmp/karpathy-tmp-$$"
        cat "/tmp/karpathy-tmp-$$" >> "$dest"
        rm -f "/tmp/karpathy-tmp-$$"
        ok "Appended to $dest"
        ;;
      *)
        warn "Skipped $name"
        ;;
    esac
  else
    download "$url" "$dest"
    ok "Created $dest"
  fi
}

install_claude_code() {
  info "Installing for Claude Code..."
  install_file "$REPO_RAW/CLAUDE.md" "./CLAUDE.md" "CLAUDE.md"
}

install_cursor() {
  info "Installing for Cursor..."
  mkdir -p .cursor/rules
  install_file "$REPO_RAW/.cursor/rules/karpathy-guidelines.mdc" \
    ".cursor/rules/karpathy-guidelines.mdc" "Cursor rule"
}

install_opencode() {
  printf "  Install as: [${BOLD}p${NC}]roject AGENTS.md / [${BOLD}s${NC}]kill (global) / [${BOLD}b${NC}]oth? "
  read -r oc_choice
  case "$oc_choice" in
    s|S)
      install_opencode_skill
      ;;
    b|B)
      install_opencode_agents
      install_opencode_skill
      ;;
    *)
      install_opencode_agents
      ;;
  esac
}

install_opencode_agents() {
  info "Installing AGENTS.md for OpenCode..."
  install_file "$REPO_RAW/AGENTS.md" "./AGENTS.md" "AGENTS.md"
}

install_opencode_skill() {
  info "Installing as OpenCode skill..."
  local skill_dir="$HOME/.config/opencode/skills/karpathy-guidelines"
  mkdir -p "$skill_dir"
  download "$REPO_RAW/skills/karpathy-guidelines/SKILL.md" "$skill_dir/SKILL.md"
  ok "Installed skill to $skill_dir/SKILL.md"
}

install_codex() {
  info "Installing for Codex..."
  install_file "$REPO_RAW/AGENTS.md" "./AGENTS.md" "AGENTS.md"
}

# --- Main ---

printf "\n${BOLD}Karpathy Guidelines Installer${NC}\n"
printf "Behavioral guidelines for AI coding assistants.\n\n"
printf "Select tools to install for (comma-separated, e.g. 1,3):\n\n"
printf "  ${BOLD}1${NC}) Claude Code  (CLAUDE.md)\n"
printf "  ${BOLD}2${NC}) Cursor       (.cursor/rules/)\n"
printf "  ${BOLD}3${NC}) OpenCode     (AGENTS.md / skill)\n"
printf "  ${BOLD}4${NC}) Codex        (AGENTS.md)\n"
printf "  ${BOLD}a${NC}) All\n"
printf "\n"
printf "Choice: "
read -r selection

# Normalize "a" to "1,2,3,4"
if [[ "$selection" == "a" || "$selection" == "A" ]]; then
  selection="1,2,3,4"
fi

printf "\n"

IFS=',' read -ra choices <<< "$selection"
for choice in "${choices[@]}"; do
  choice="$(echo "$choice" | tr -d ' ')"
  case "$choice" in
    1) install_claude_code ;;
    2) install_cursor ;;
    3) install_opencode ;;
    4) install_codex ;;
    *) warn "Unknown option: $choice" ;;
  esac
done

printf "\n${GREEN}${BOLD}Done!${NC}\n"
printf "For more info, see: https://github.com/forrestchang/andrej-karpathy-skills\n\n"
