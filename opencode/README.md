# OpenCode container

This is project creates a container for [OpenCode](https://github.com/sst/opencode).
Both podman and docker should work (I use podman BTW).


The container is based on [archlinux](https://archlinux.org/) because:

1. [Alpine](https://www.alpinelinux.org/) did not work (my fault?).
2. I had to try archlinux, how else can I say "I use … BTW"?
3. [Fedora](https://www.fedoraproject.org/) would be too easy, but I'll learn nothing new.


## Usage

Configuration can be done in `$HOME/.local/share/opencode` and `$HOME/.config/opencode`, both are mounted in the container.

Find the [opencode](scripts/opencode) script to automate the use (podman or docker).


## Feedback

Feel free to clone the project, open PRs and bug reports.
