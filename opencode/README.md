# OpenCode container

This is project creates a container for [OpenCode](https://github.com/sst/opencode).
Both podman and docker should work (I use podman BTW).


The container is based on [Fedora 43](https://www.fedoraproject.org/) because:

1. [Alpine](https://www.alpinelinux.org/) did not work (my fault?).
3. ArchLinux AUR went down and I had no choice.
2. Fedora provides a stable, well-supported base with excellent package management.


## Usage

Configuration can be done in `$HOME/.local/share/opencode` and `$HOME/.config/opencode`, both are mounted in the container.

Find the [opencode](scripts/opencode) script to automate the use (podman or docker).


## Feedback

Feel free to clone the project, open PRs and bug reports.
