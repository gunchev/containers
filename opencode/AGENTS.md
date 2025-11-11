# OpenCode Container - Agent Guidelines

## Build/Lint/Test Commands
- Build: `make all` or `make image` (podman/docker, linux/amd64)
- Build specific version: `make image VERSION=1.0.51` (build specific opencode version)
- Clean: `make clean` (remove generated container files)
- Help: `make help` (show available targets)
- Lint: `make lint` (runs shellcheck, hadolint, yamllint, jq validation)
- Format: `prettier` (JS/TS/CSS/HTML/JSON/YAML/Markdown), `autopep8` (Python)
- Test: `make test` (runs nested container test: podman run alpine echo hello)

## Code Style Guidelines
- Text Files: Always add trailing newline per [POSIX standard](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_206)
- Indentation: 4 spaces (Python/C/C++/shell), 2 spaces (JS/JSON/HTML/YAML), tabs (Makefile/Go)
- Max line length: 120 characters, UTF-8 with LF endings, trim trailing whitespace
- Shell scripts: `#!/usr/bin/env bash`, `set -euo pipefail`, `shopt -s nullglob dotglob`
- Container detection: `CONTAINER_CMD=$(if command -v podman >/dev/null 2>&1; then echo "podman"; else echo "docker"; fi)`
- Use `exec` to replace shell process, avoid subshells
- Naming: lowercase_with_underscores, UPPERCASE constants
- Always quote variables: `"${VAR}"`, use arrays for multiple arguments
- Functions: Use `local` for variables, avoid global scope pollution
- Error handling: Check command existence, provide meaningful error messages
- Dockerfile: Multi-stage builds, combine RUN layers, use ARG for versions
- JSONC: Use JSON with comments for configuration files (configs/*.jsonc)

## Project Structure
Fedora 43-based container with OpenCode CLI tool pre-installed.
