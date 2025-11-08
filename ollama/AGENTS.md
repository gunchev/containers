# AGENTS.md

## Build Commands
- `make image` or `make all`: Build the ollama container image.
- `make clean`: Remove generated images.
- `make image TAG=my_flavour`: Build with custom tag.

## Testing
- `./scripts/ollama_test_nvidia_gpu`: Test NVIDIA GPU access in container (single test).
- `./scripts/ollama_serve`: Start ollama server in background for integration testing.
- `./scripts/ollama <args>`: Execute ollama commands in running container for manual testing.
- No automated test suite; manual testing via scripts required.

## Code Style Guidelines
- **Text Files**: Always add trailing new line in all text files as defined in the [POSIX standard](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_206).
- **Max line length**: 120 characters.
- **Text Encoding**: UTF-8 encoding with LF line endings, trim trailing whitespace.
- **Shell scripts**: Use `#!/usr/bin/env bash` shebang.
- **Error handling**: Always include `set -euo pipefail` and `shopt -s nullglob dotglob`.
- **Container detection**: `CONTAINER_CMD=$(if command -v podman >/dev/null 2>&1; then echo "podman"; else echo "docker"; fi)`.
- **Execution**: Use `exec` for script execution to replace shell process.
- **Container flags**: `--network=host --device nvidia.com/gpu=all --security-opt=label=disable`.
- **Volume mounts**: `-v "${HOME}/.ollama:/root/.ollama"` for persistent storage.
- **Naming**: Use lowercase with underscores for variables (e.g., `container_cmd`).
- **Quotes**: Always quote variables and paths containing spaces.
- **Functions**: Use `local` for function variables; avoid global scope pollution.
- **Documentation**: Add comments for complex logic; keep scripts self-documenting.
