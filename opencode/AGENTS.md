# OpenCode Container - Agent Guidelines

## Build Commands
- `make all` or `make opencode-image`: Build container with podman/docker (linux/amd64)
- `make clean`: Remove generated container files
- `make help`: Show available targets

## Code Style Guidelines
- Text Files: Always add trailing new line in all text files as defined in the [POSIX standard](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_206).
- Indentation: 4 spaces (Python/C/C++/shell), 2 spaces (JS/JSON/HTML/YAML), tabs (Makefile/Go)
- Max line length: 120 characters
- UTF-8 encoding with LF line endings, trim trailing whitespace
- Follow EditorConfig settings in .editorconfig
- Public domain licensing (Unlicense)

## Project Structure
ArchLinux-based container project with OpenCode CLI tool pre-installed.
Focus on container image creation and deployment automation.
