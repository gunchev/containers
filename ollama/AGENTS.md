# AGENTS.md

## Build Commands
- `make image` or `make all`: Build ollama container as localhost/ollama:latest
- `make clean`: Remove generated images
- `make image VERSION=x.y.z`: Build specific ollama version
- `make help`: Show available targets and usage

## Testing
- `./scripts/ollama_test_nvidia_gpu`: Test NVIDIA GPU access (single test)
- `./scripts/ollama_serve`: Start ollama server for integration testing
- `./scripts/ollama <args>`: Execute ollama commands in container for manual testing
- No automated test suite; use scripts for manual testing

## Code Style Guidelines
- **Shell scripts**: `#!/usr/bin/env bash`, `set -euo pipefail`, `shopt -s nullglob dotglob`
- **Container detection**: `CONTAINER_CMD=$(if command -v podman >/dev/null 2>&1; then echo "podman"; else echo "docker"; fi)`
- **Execution**: Use `exec` to replace shell process; avoid subshells
- **Container flags**: `--network=host --device nvidia.com/gpu=all --security-opt=label=disable`
- **Volume mounts**: `-v "${HOME}/.ollama:/root/.ollama"` for persistent storage
- **Naming**: Lowercase with underscores (e.g., `container_cmd`), UPPERCASE for constants
- **Quotes**: Always quote variables: `"${VAR}"`, use arrays for multiple arguments
- **Functions**: Use `local` for variables; avoid global scope pollution
- **Text files**: UTF-8, LF endings, 120 char lines, trailing newlines, trim whitespace
- **Error handling**: Check command existence before use, provide meaningful error messages
- **Dockerfile**: Multi-stage builds, combine RUN layers, use ARG for versions
- **Makefile**: Use .PHONY for non-file targets, proper shell detection
