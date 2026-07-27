# Ollama Container

A containerized setup for running [Ollama](https://ollama.com/) with GPU support using Podman or Docker.
This project provides an easy way to run Ollama AI models in containers with NVIDIA GPU acceleration.


## Features

- 🐳 Containerized Ollama with Fedora base image
- 🎮 NVIDIA GPU support via container toolkit
- 🛠️ Support for both Podman and Docker
- 🔧 Automated container runtime detection
- 📦 Pre-installed monitoring tools (nvtop, htop, nnn, nmap-ncat)
- 🏃‍♂️ Unified script interface for all operations


## Prerequisites

- Linux system with Podman or Docker installed
- NVIDIA GPU with drivers (optional, but recommended for GPU acceleration)
- NVIDIA Container Toolkit (automatically installed in container)


## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/gunchev/containers
   cd containers/ollama
   ```

2. Build the container image with the latest ollama version available:
   ```bash
   make image
   ```

   Or a specific version:
   ```bash
   make image VERSION=0.3.12   # explicitly specify version
   ```


## Usage

Copy or symlink the unified script from `scripts/ollama` in your `~/bin/` directory and add it to your `${PATH}` for easy access.
```bash
ln -s "${PWD}"/scripts/ollama ~/bin/
```


### Unified Script Interface

The `ollama` script provides a unified interface for all operations:

```bash
# Start the ollama server
./scripts/ollama start
# or
./scripts/ollama serve

# Stop the ollama server
./scripts/ollama stop

# Run ollama commands
./scripts/ollama list
./scripts/ollama pull llama2
./scripts/ollama run llama2

# Get shell access to the running container
./scripts/ollama shell

# Show help
./scripts/ollama help
```

### Command Examples

```bash
# Start the server in background
./scripts/ollama start

# List available models
./scripts/ollama list

# Pull a model
./scripts/ollama pull llama2

# Run a model
./scripts/ollama run llama2 "Hello, how are you?"

# Get shell access for debugging
./scripts/ollama shell

# Stop the server when done
./scripts/ollama stop
```


### Test GPU Access

```bash
./scripts/ollama_test_nvidia_gpu
```

This runs a quick test to verify NVIDIA GPU access in the container. Will print all available and accessible GPUs.


## Development


### Build Commands

- `make image` or `make all`: Build the container image
- `make clean`: Remove generated images
- `make image VERSION=custom`: Build with custom version


### Scripts

- `./scripts/ollama`: Unified script for all ollama operations
- `./scripts/ollama_test_nvidia_gpu`: Test GPU access


## License

Unlicense License - see [LICENSE file](LICENSE) for details.


## Feedback

Feel free to clone the project, open PRs and bug reports.
Text Files should end with  trailing new line as defined in the [POSIX standard](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_206).


## Configuration

The container is configured with:
- Host networking (`--network=host`)
- GPU device access (`--device nvidia.com/gpu=all`)
- Security label disabled (`--security-opt=label=disable`)
- Persistent storage mounted (`${HOME}/.ollama:/home/podman/.ollama`)


## Troubleshooting


### GPU Issues

- Ensure NVIDIA drivers are installed on host
- Verify NVIDIA Container Toolkit is available
- Check GPU access with: `nvidia-smi`


### Container Runtime

- The scripts automatically detect Podman vs Docker
- Default preference: Podman > Docker


## Resources

- [Ollama Documentation](https://github.com/ollama/ollama)
- [Podman GPU Guide](https://podman-desktop.io/docs/podman/gpu)
- [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/cdi-support.html)
- [Fedora NVIDIA Discussion](https://discussion.fedoraproject.org/t/create-toolbox-with-gpu-via-nvidia-container-toolkit/100673)
