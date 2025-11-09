SHELL := /usr/bin/env bash
# ^^^ use bash syntax, mitigates dash's printf on Debian(Ubuntu?), works on MacOS.

# Detect if podman is available, otherwise use docker.
CONTAINER_CMD := $(shell if command -v podman >/dev/null 2>&1; then echo "podman"; else echo "docker"; fi)

# The container name
IMAGE_NAME = ollama
# Use version from the user or autodetect the ltatest.
VERSION ?= $(shell curl -s https://api.github.com/repos/ollama/ollama/releases/latest | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/')



.PHONY: help
help:
	@echo
	@echo "▍Help"
	@echo "▀▀▀▀▀▀"
	@echo
	@echo "Available targets:"
	@echo "    all, image:   Create the container image."
	@echo "    clean:        Clean all generated files and images."
	@echo
	@echo "Usage:"
	@echo "    make image"
	@echo "    make image VERSION=0.3.11  # Build specific (older) version"
	@echo
	@echo "Developer info:"
	@printf -- "- SHELL=%q, CONTAINER_CMD=%q, VERSION=%q.\n\n" "$(SHELL)" "$(CONTAINER_CMD)" "$(VERSION)"



.PHONY: all
all: image



.PHONY: image
image:
	"$(CONTAINER_CMD)" build --build-arg VERSION=$(VERSION) --platform linux/amd64 \
            --tag localhost/$(IMAGE_NAME):$(VERSION) --tag localhost/$(IMAGE_NAME):latest .



.PHONY: clean
clean:
	"$(CONTAINER_CMD)" image rm "localhost/$(IMAGE_NAME):$(VERSION)" "localhost/$(IMAGE_NAME):latest"
