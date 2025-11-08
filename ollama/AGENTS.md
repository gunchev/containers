# AGENTS.md

## Build Commands
- `make image` or `make all`: Build the ollama container image
- `make clean`: Remove generated images
- `make image TAG=custom`: Build with custom tag

## Testing
- `./scripts/ollama_test_nvidia_gpu`: Test NVIDIA GPU access (single test)
- `./scripts/ollama_serve`: Start ollama server for integration testing
- `./scripts/ollama <args>`: Execute ollama commands in container for manual testing
- No automated test suite; use scripts for manual testing

## Code Style Guidelines
- **Shell scripts**: Use `#!/usr/bin/env bash` shebang, `set -euo pipefail`, `shopt -s nullglob dotglob`
- **Container detection**: `CONTAINER_CMD=$(if command -v podman >/dev/null 2>&1; then echo "podman"; else echo "docker"; fi)`
- **Execution**: Use `exec` for script execution to replace shell process
- **Container flags**: `--network=host --device nvidia.com/gpu=all --security-opt=label=disable`
- **Volume mounts**: `-v "${HOME}/.ollama:/root/.ollama"` for persistent storage
- **Naming**: Lowercase with underscores for variables (e.g., `container_cmd`)
- **Quotes**: Always quote variables and paths with spaces
- **Functions**: Use `local` for function variables; avoid global scope pollution
- **Text files**: UTF-8, LF endings, 120 char max line length, trailing newlines, trim whitespace
- **Documentation**: Add comments for complex logic; keep scripts self-documenting
