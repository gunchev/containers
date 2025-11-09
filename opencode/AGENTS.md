# OpenCode Container - Agent Guidelines

## Build/Lint/Test Commands
- Build: `make all` or `make opencode-image` (podman/docker, linux/amd64)
- Clean: `make clean` (remove generated container files)
- Help: `make help` (show available targets)
- Lint: `shellcheck` (shell), `pylint` (Python), `autopep8 --diff` (Python), `yamllint` (YAML), `markdownlint-cli` (Markdown), `hadolint` (Dockerfiles)
- Format: `prettier` (JS/TS/CSS/HTML/JSON/YAML/Markdown), `autopep8` (Python)
- Test: `vitest` (JavaScript/TypeScript), no specific test commands (container project, manual testing via container builds)

## Code Style Guidelines
- Text Files: Always add trailing newline per [POSIX standard](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_206)
- Indentation: 4 spaces (Python/C/C++/shell), 2 spaces (JS/JSON/HTML/YAML), tabs (Makefile/Go)
- Max line length: 120 characters
- UTF-8 encoding with LF line endings, trim trailing whitespace
- Public domain licensing (Unlicense)
- Bash: Use `set -euo pipefail`, quote variables, prefer `[[ ]]` over `[ ]`

## Project Structure
Fedora 43-based container project with OpenCode CLI tool pre-installed.
Focus on container image creation and deployment automation.

## Troubleshooting
- Build failures: Ensure network connectivity and retry build
- Container runtime: Both podman and docker are supported
