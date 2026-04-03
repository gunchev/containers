# OpenCode Container - Agent Guidelines

This repository contains a Fedora 43-based container image with [OpenCode](https://github.com/sst/opencode) CLI tool pre-installed.

## Build/Lint/Test Commands

### Building the Container
```bash
make all          # Build container (same as 'make image')
make image        # Build container with latest opencode version
make image VERSION=1.0.51  # Build specific opencode version
```

### Cleaning
```bash
make clean        # Remove generated images (latest and VERSION tags)
```

### Linting
```bash
make lint         # Run all linters (shellcheck, hadolint, yamllint, jq)
```

### Testing
```bash
make test          # Run nested container test (podman inside opencode container)
```

### Other Targets
```bash
make help          # Show available Makefile targets
make toolbox       # Create a toolbox container for persistent access
```

### Running the Container
```bash
./scripts/opencode                    # Using the helper script (recommended)
podman run -it --security-opt label=disable --device /dev/fuse \
  --cap-add SYS_ADMIN,MKNOD localhost/opencode:latest
```

## Code Style Guidelines

### Text Files - General
- **Trailing newline**: Always end files with a single newline (POSIX standard)
- **Line endings**: LF (Unix-style), UTF-8 encoding
- **Trailing whitespace**: Trim all trailing whitespace
- **Max line length**: 120 characters

### Indentation
| Language/Format | Indentation |
|-----------------|-------------|
| Shell/Python/Makefile | 4 spaces |
| YAML/JSON/JSONC/HTML | 2 spaces |
| Go | tabs |

### Shell Scripts
```bash
#!/usr/bin/env bash              # Use bash, not sh/dash
set -euo pipefail                # Strict error handling
shopt -s nullglob dotglob        # Path expansion options
```

### Variables and Constants
```bash
# Always quote variables: "${VAR}"
# Use arrays for multiple args: args=(--foo bar); cmd "${args[@]}"
# Constants in UPPERCASE: readonly MAX_RETRIES=5
```

### Functions
```bash
function my_function() {
    local var1="$1"              # Use local to avoid global scope pollution
}
```

### Container Detection Pattern
```bash
CONTAINER_CMD=$(if command -v podman >/dev/null 2>&1; then echo "podman"; else echo "docker"; fi)
```

### Process Replacement (exec)
```bash
exec "$CONTAINER_CMD" run "$@"   # Use exec to replace shell process
```

### Error Handling
```bash
if ! command -v somecmd >/dev/null 2>&1; then
    echo "Error: somecmd not found" >&2
    exit 1
fi
die() { echo "Error: $*" >&2; exit 1; }
```

### Naming Conventions
| Type | Convention | Example |
|------|------------|---------|
| Variables | lowercase_with_underscores | `output_file` |
| Constants | UPPERCASE_WITH_UNDERSCORES | `MAX_RETRIES` |
| Functions | lowercase_with_underscores | `build_image()` |
| Image names | lowercase-with-hyphens | `opencode-container` |

### Dockerfiles (Containerfile)
- Use multi-stage builds when beneficial
- Combine related RUN layers to reduce image size
- Use `ARG` for versioned build arguments
- Prefer `--mount=type=cache` for package manager caches
- Use `printf` for multiline content

```dockerfile
RUN --mount=type=cache,dst=/var/cache/libdnf5/ \
    dnf makecache && dnf install package --exclude container-selinux
```

### JSON/JSONC Files
- Use `.jsonc` extension for JSON with comments
- Use `//` for comments in JSONC files
- Validate with `jq empty file.jsonc`

### YAML Files
- 2-space indentation
- Validate with `yamllint`

### Makefiles
- Use tabs for indentation (not spaces)
- Define `.PHONY` targets explicitly

## Project Structure

```
opencode/
├── AGENTS.md           # This file
├── Makefile            # Build/lint/test automation
├── Containerfile       # Container image definition
├── containers.conf     # Container runtime config
├── README.md           # User documentation
├── configs/
│   └── opencode.jsonc  # Sample OpenCode configuration
└── scripts/
    └── opencode        # Helper script to run the container
```

## Container Configuration

The container requires:
- FUSE device: `--device /dev/fuse`
- Capabilities: `--cap-add SYS_ADMIN,MKNOD`
- Security: `--security-opt label=disable`
- User namespace: `--userns=keep-id`

Mounted volumes:
- `${PWD}` - current working directory
- `${HOME}/.config/opencode` - configuration
- `${HOME}/.local/share/opencode` - data
- `${HOME}/.local/share/containers` - container storage
