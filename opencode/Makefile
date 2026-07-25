SHELL := /usr/bin/env bash
# ^^^ use bash syntax, mitigates dash's printf on Debian(Ubuntu?), works on MacOS.

# Detect if podman is available, otherwise use docker.
CONTAINER_CMD := $(shell if command -v podman >/dev/null 2>&1; then echo "podman"; else echo "docker"; fi)

# The container name
IMAGE_NAME = opencode
# Use version from the user or autodetect the latest.
VERSION ?= $(shell curl -sL https://api.github.com/repos/sst/opencode/releases/latest | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/')



.PHONY: help
help:
	@echo
	@echo "▍Help"
	@echo "▀▀▀▀▀▀"
	@echo
	@echo "Available targets:"
	@echo "    all, image:   Create the container image."
	@echo "    clean:        Clean all generated files and images."
	@echo "    lint:         Run linters on project files."
	@echo "    test:         Run a container inside the opencode container to print hello world."
	@echo "    toolbox:      Create toolbox"
	@echo
	@echo "Usage:"
	@echo "    make image"
	@echo "    make image VERSION=1.0.51  # Build specific (older) version"
	@echo
	@echo "Developer info:"
	@printf -- "- SHELL=%q, CONTAINER_CMD=%q, VERSION=%q.\n\n" "$(SHELL)" "$(CONTAINER_CMD)" "$(VERSION)"



.PHONY: all
all: image



.PHONY: image
image:
	"$(CONTAINER_CMD)" build \
            --build-arg VERSION=$(VERSION) \
            --tag localhost/$(IMAGE_NAME):$(VERSION) --tag localhost/$(IMAGE_NAME):latest .



.PHONY: clean
clean:
	-$(CONTAINER_CMD) image rm $(IMAGE_NAME):latest 2>/dev/null || true
	-$(CONTAINER_CMD) image rm $(IMAGE_NAME):$(VERSION) 2>/dev/null || true


.PHONY: prune
prune:
	@echo "Pruning dangling images…"
	@$(CONTAINER_CMD) image prune -f
	@echo "Pruning dangling/anonymous volumes…"
	@$(CONTAINER_CMD) volume prune -f


.PHONY: clean-all
clean-all: clean prune
	@echo "Toolbox container still present? Remove with: toolbox rm --force $(IMAGE_NAME)-toolbox"



.PHONY: lint
lint:
	@echo "Running linters..."
	@echo "Shell scripts:"
	@shellcheck scripts/*
	@echo "Containerfile:"
	@hadolint Containerfile
	@echo "YAML files:"
	@find . -name "*.yml" -o -name "*.yaml" | xargs yamllint
	@echo "JSON files:"
	@find . -name "*.json" -o -name "*.jsonc" | xargs -I {} sh -c 'echo "Checking {}:" && jq empty {}'
	@echo "Linting complete."



.PHONY: test
test:
	podman run --rm --security-opt label=disable --user podman --device /dev/fuse --userns=keep-id localhost/opencode:latest opencode --version
	@podman run --rm --security-opt label=disable --user podman --device /dev/fuse --userns=keep-id localhost/opencode:latest podman info --format '{{.Host.Security.RootlessUIDMapping}}' && echo "rootless container stack reachable" \
		|| echo "Skipping nested podman check (requires newuidmap on host)"



.PHONY: toolbox
toolbox:
	toolbox create -c opencode-toolbox -i localhost/opencode:latest
	echo "Use 'toolbox enter opencode-toolbox' to enter the toolbox"
