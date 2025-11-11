# OpenCode container

A containerized setup for running [OpenCode](https://github.com/sst/opencode) using Podman or Docker.
Both podman and docker should work (I use podman BTW).

The container is based on [Fedora 43](https://www.fedoraproject.org/) because:

1. [Alpine](https://www.alpinelinux.org/) did not work (my fault?).
2. ArchLinux AUR went down and I had no choice, so I don't use Arch BTW :-(
3. Fedora provides a stable, well-supported base with excellent package management. The image also turns out to be smaller.


## Features

- 🐳 Containerized OpenCode with Fedora base image
- 🛠️ Support for both Podman and Docker
- 🔧 Automated container runtime detection
- 📦 Pre-installed agent tools (pylint, fzf, clang-check, make, ninja)
- 🏃 Ready-to-use scripts for testing and deployment


## Prerequisites

- Linux system with Podman or Docker installed
- Internet connection for downloading packages and OpenCode


## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/gunchev/containers
   cd containers/opencode
   ```

2. Build the container image with the latest opencode version available:
   ```bash
   make all
   ```

   Or a specific version:
   ```bash
   make image VERSION=1.0.51  # explicitly specify version
   ```


## Usage

Configuration can be done in `$HOME/.local/share/opencode` and `$HOME/.config/opencode`, both are mounted in the container.

Find the [opencode](scripts/opencode) script to automate the use (podman or docker).

Copy or symlink the scripts from `scripts/*` in your `~/bin/` directory and add it to your `${PATH}` for easy access.
```bash
ln -s "${PWD}"/scripts/* ~/bin/
```

Example usage:
```bash
# Run OpenCode in current directory
opencode

# Pass arguments to OpenCode
opencode --help
```


## License

Unlicense License - see [LICENSE file](LICENSE) for details.


## Feedback

Feel free to clone the project, open PRs and bug reports.
Text Files should end with  trailing new line as defined in the [POSIX standard](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_206).


## Configuration

The container is configured with:
- TERM environment variable forwarded
- Persistent storage mounted for:
  - `$HOME/.local/share/opencode` (data directory)
  - `$HOME/.config/opencode` (configuration directory)
  - `$HOME/.local/share/containers` (container storage)
- Network access via host networking
- FUSE device support for nested containers


## Troubleshooting

### Common Issues

- **Permission denied**: Ensure user is in appropriate groups for Podman/Docker
- **Container fails to start**: Check if `/dev/fuse` is available and accessible
- **Network issues**: Verify host networking is properly configured
- **Storage problems**: Ensure sufficient disk space and proper permissions

### Container Runtime

- The scripts automatically detect Podman vs Docker
- Default preference: Podman > Docker

### Security Considerations

This container requires elevated privileges:
- `--cap-add SYS_ADMIN,MKNOD` for container management
- `--device /dev/fuse` for overlay filesystem support
- `--security-opt label=disable` for nested containers
Only run trusted code and review security implications for your environment.


## Resources

- [OpenCode Documentation](https://opencode.ai/docs)
- [How to use Podman inside of a container](https://www.redhat.com/en/blog/podman-inside-container)
- [Podman Image](https://github.com/containers/image_build/tree/main/podman)
