# Containers

Personal container image recipes for various tools.
Built and tested with [Podman](https://podman.io/), but should work just fine with [Docker](https://www.docker.com/) too (autodetected).
You can use any, but use Podman with a non-root user.


## Images

- [Ollama](https://ollama.com/) | Chat & build with open models.
- [OpenCode](https://opencode.ai/) | The AI coding agent built for the terminal.
- [Pi](https://pi.dev/) | Minimal terminal coding agent harness (npm: [@earendil-works/pi-coding-agent](https://www.npmjs.com/package/@earendil-works/pi-coding-agent)).


## Feedback

Feel free to clone the project, open PRs and bug reports.


## Common Makefile targets

Every subdirectory has the same skeleton:

```bash
make image           # build, autodetect latest version
make image VERSION=… # pin a specific version
make test            # run the tool --version inside the container
make toolbox         # register as a `toolbox` container (host integration)
make clean           # remove this image's `:latest` + `:VERSION` tags
make prune           # drop dangling images + anonymous volumes
make clean-all       # clean + prune (keeps the toolbox container, see note)
```

Use `toolbox rm --force <name>-toolbox` to remove the toolbox container itself.
