# Pi container

A containerized setup for running [Pi](https://pi.dev/) using Podman or Docker.
Both podman and docker should work (I use podman BTW).

The container is based on [Fedora 44](https://www.fedoraproject.org/) because:

1. [Alpine](https://www.alpinelinux.org/) did not work (my fault?).
2. ArchLinux AUR went down and I had no choice, so I don't use Arch BTW :-(
3. Fedora provides a stable, well-supported base with excellent package management. The image also turns out to be smaller.

Pi itself is installed globally via npm from
the [`@earendil-works/pi-coding-agent`](https://www.npmjs.com/package/@earendil-works/pi-coding-agent)
package, the exact same source the official `https://pi.dev/install.sh` uses.


## Features

- 🐳 Containerized Pi with Fedora 44 base image
- 🛠️ Support for both Podman and Docker
- 🔧 Automated container runtime detection
- 📦 Pre-installed agent tools (pylint, fzf, clang-check, make, ninja)
- 🏃 Ready-to-use scripts for testing and deployment
- 🧠 npm-based Pi install so `pi install npm:...` works inside the container


## Prerequisites

- Linux system with Podman or Docker installed
- Internet connection for downloading packages and Pi
- Node.js >= 22.19 will be installed automatically (Pi's minimum requirement)


## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/gunchev/containers
   cd containers/pi
   ```

2. Build the container image with the latest pi version available:
   ```bash
   make all
   ```

   Or a specific version:
   ```bash
   make image VERSION=0.82.0  # explicitly specify version
   ```

   `VERSION` is forwarded to `npm install -g @earendil-works/pi-coding-agent@${VERSION:-latest}`,
   so any tag, dist-tag or SemVer range accepted by npm works. Empty `VERSION=` forces the
   `latest` dist-tag.


## Usage

Configuration lives in `$HOME/.pi/agent` (sessions, settings, prompts, skills, themes,
extensions, packages). Optionally mount `$HOME/.config/pi` and `$HOME/.local/share/pi`
for additional state.

Find the [pi](scripts/pi) script to automate the use (podman or docker). The helper
mounts `~/.pi/agent` into `$HOME/.pi/agent` inside the container so the binary sees the
same data the host pi would.

Copy or symlink the scripts from `scripts/*` in your `~/bin/` directory and add it to your `${PATH}` for easy access.
```bash
ln -s "${PWD}"/scripts/* ~/bin/
```

Example usage:
```bash
# Run Pi in current directory on top of the host ~/.pi/agent
pi

# Pass arguments to Pi
pi --help

# Run with a temporary / fresh state (skip ~/.pi/agent mount by editing scripts/pi)
pi --no-session -p "Summarize the cwd"
```


## License

Unlicense License - see [LICENSE file](../LICENSE) for details.


## Feedback

Feel feel free to clone the project, open PRs and bug reports.
Text files should end with a trailing new line as defined in the [POSIX standard](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_206).


## Configuration

The container is configured with:
- TERM environment variable forwarded
- Persistent storage mounted for:
  - `$HOME/.pi/agent` (sessions, settings, prompts, skills, themes, extensions, packages)
  - `$HOME/.config/pi` (additional user-level config)
  - `$HOME/.local/share/pi` (Pi data directory)
  - `$HOME/.local/share/containers` (nested container storage)
- Network access via host networking
- FUSE device support for nested containers


## Troubleshooting

### Common Issues

- **Permission denied**: Ensure user is in appropriate groups for Podman/Docker
- **Container fails to start**: Check if `/dev/fuse` is available and accessible
- **Network issues**: Verify host networking is properly configured
- **Storage problems**: Ensure sufficient disk space and proper permissions
- **npm permission errors during build**: Fedora 44's `nodejs` package should already
  install Node >= 22.19; if not, install via NodeSource or `npm install -g n` first.

### Container Runtime

- The scripts automatically detect Podman vs Docker
- Default preference: Podman > Docker

### Security Considerations

This container requires elevated privileges:
- `--cap-add SYS_ADMIN,MKNOD` for container management
- `--device /dev/fuse` for overlay filesystem support
- `--security-opt label=disable` for nested containers
Only run trusted code and review security implications for your environment.


## Defaults Out-of-the-box

The image bakes in:

- `~/.pi/agent/settings.json` with `autoupdate: false`, `enableInstallTelemetry: false`,
  `defaultProjectTrust: "never"` (seeded via `/etc/skel`, copied to your `$HOME`
  by `toolbox init-container` on first enter).
- `PI_SKIP_VERSION_CHECK=1`, `PI_TELEMETRY=0`, `PI_OFFLINE=0` set as env vars.
- An in-container `podman` user (uid 1000) so `--user podman`, `--userns=keep-id`,
  and the nested-podman smoke test in `make test` work without `adduser` steps.

Disable the env vars at run-time if you want pi's online checks back:

```bash
podman run --rm --env PI_OFFLINE= -e PI_SKIP_VERSION_CHECK= -e PI_TELEMETRY \
    localhost/pi:latest pi --help
```


## Resources

- [Pi Documentation](https://pi.dev/)
- [Pi coding-agent on GitHub](https://github.com/earendil-works/pi/tree/main/packages/coding-agent)
- [@earendil-works/pi-coding-agent on npm](https://www.npmjs.com/package/@earendil-works/pi-coding-agent)
- [Offline providers guide](docs/pi-coding-agent-providers.html)
- [Offline CLI reference](docs/pi-cli-reference.txt)
- [How to use Podman inside of a container](https://www.redhat.com/en/blog/podman-inside-container)
- [Podman Image](https://github.com/containers/image_build/tree/main/podman)


## OCI image labels

`podman inspect localhost/pi:latest` shows:

```
org.opencontainers.image.title=pi
org.opencontainers.image.description=Minimal terminal coding agent (pi.dev) on Fedora 44 with full opencode toolchain
org.opencontainers.image.source=https://github.com/gunchev/containers/tree/master/pi
org.opencontainers.image.documentation=https://pi.dev/
org.opencontainers.image.vendor=dgunchev
org.opencontainers.image.licenses=Unlicense
```
