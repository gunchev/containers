# OpenCode Container - Agent Guidelines

## Build Commands
- `make all` or `make opencode-image`: Build container with podman/docker (linux/amd64)
- `make clean`: Remove generated container files
- `make help`: Show available targets

## Code Style Guidelines
- Indentation: 4 spaces (Python/C/C++/shell), 2 spaces (JS/JSON/HTML/YAML), tabs (Makefile/Go)
- Max line length: 120 characters
- UTF-8 encoding with LF line endings, trim trailing whitespace
- Follow EditorConfig settings in .editorconfig
- Public domain licensing (Unlicense)

## Project Structure
ArchLinux-based container project with OpenCode CLI tool pre-installed.
Focus on container image creation and deployment automation.
