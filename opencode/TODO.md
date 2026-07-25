# OpenCode container TODO

TODO list:

- [x] Install [hadolint-bin](https://aur.archlinux.org/packages/hadolint-bin) or [hadolint](https://aur.archlinux.org/packages/hadolint).
- [x] Get rid of `https://opencode.ai/install`, do the steps manually.
- [x] Support building specific opencode version container.
- [x] Add `podman` user (UID 1000) so `make test` (and `--userns=keep-id` from the
      helper script) can map the host's first user into the container.
