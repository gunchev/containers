SHELL := /usr/bin/env bash # Use bash syntax, mitigates dash's printf on Debian(Ubuntu?), works on MacOS.

# Detect if podman is available, otherwise use docker.
CONTAINER_CMD := $(shell if command -v podman >/dev/null 2>&1; then echo "podman"; else echo "docker"; fi)

# Allow overriding the image tag via `make opencode-image TAG=1.0.0`.
TAG ?= latest
IMAGE_NAME = opencode
FULL_IMAGE_NAME = $(IMAGE_NAME):$(TAG)



.PHONY: help
help:
	@echo
	@echo "▍Help"
	@echo "▀▀▀▀▀▀"
	@echo
	@echo "Available targets:"
	@echo "    all, opencode-image: Create the container."
	@echo "    clean:               Clean all generated files and images."
	@echo
	@echo "Usage:"
	@echo "    make opencode-image TAG=1.0.0  # Build with a custom tag"
	@echo



all: opencode-image



.PHONY: opencode-image
opencode-image:
	$(CONTAINER_CMD) build --platform linux/amd64 --tag $(FULL_IMAGE_NAME) .



.PHONY: clean
clean:
	$(CONTAINER_CMD) image rm $(IMAGE_NAME)
