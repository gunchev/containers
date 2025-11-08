SHELL := /usr/bin/env bash # Use bash syntax, mitigates dash's printf on Debian(Ubuntu?), works on MacOS.

# Detect if podman is available, otherwise use docker.
CONTAINER_CMD := $(shell if command -v podman >/dev/null 2>&1; then echo "podman"; else echo "docker"; fi)

# Allow overriding the image tag via `make opencode-image TAG=my_flavour`.
TAG ?= latest
IMAGE_NAME = ollama



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
	@echo "    make image TAG=my_flavour  # Build with a custom tag"
	@echo



.PHONY: all
all: image



.PHONY: image
image:
	$(CONTAINER_CMD) build --platform linux/amd64 --tag $(IMAGE_NAME):$(TAG) .
	$(CONTAINER_CMD) tag $(IMAGE_NAME):$(TAG) $(IMAGE_NAME):$(shell $(CONTAINER_CMD) run --rm $(IMAGE_NAME):$(TAG) ollama --version | grep version | sed 's/.* version is //g')



.PHONY: clean
clean:
	$(CONTAINER_CMD) image rm $(IMAGE_NAME)
