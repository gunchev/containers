# Ollama Container

A containerized setup for running [Ollama](https://ollama.com/) with GPU support using Podman or Docker.
This project provides an easy way to run Ollama AI models in containers with NVIDIA GPU acceleration.


## Features

- 🐳 Containerized Ollama with Fedora base image
- 🎮 NVIDIA GPU support via container toolkit
- 🛠️ Support for both Podman and Docker
- 🔧 Automated container runtime detection
- 📦 Pre-installed monitoring tools (nvtop, htop, ncdu, nnn, nmap-ncat)
- 🏃‍♂️ Ready-to-use scripts for testing and deployment


## Prerequisites

- Linux system with Podman or Docker installed
- NVIDIA GPU with drivers (optional, but recommended for GPU acceleration)
- NVIDIA Container Toolkit (automatically installed in container)


## Installation

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd containers/ollama
   ```

2. Build the container image:
   ```bash
   make image
   ```

   Or with a custom tag:
   ```bash
   make image TAG=my_custom_tag
   ```


## Usage


### Start Ollama Server

```bash
./scripts/ollama_serve
```

This starts the Ollama server in the background with GPU support.


### Run Ollama Commands

```bash
./scripts/ollama run llama2
./scripts/ollama list
./scripts/ollama pull llama2
```


### Test GPU Access

```bash
./scripts/ollama_test_nvidia_gpu
```

This runs a quick test to verify NVIDIA GPU access in the container.


## Development

Text Files should end with  trailing new line as defined in the [POSIX standard](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_206).


### Build Commands

- `make image` or `make all`: Build the container image
- `make clean`: Remove generated images
- `make image TAG=custom`: Build with custom tag


### Scripts

- `./scripts/ollama_test_nvidia_gpu`: Test GPU access
- `./scripts/ollama_serve`: Start server for integration testing
- `./scripts/ollama <args>`: Execute commands in container


## License

Unlicense License - see [LICENSE file](LICENSE) for details.


## Feedback

Feel free to clone the project, open PRs and bug reports.


## Configuration

The container is configured with:
- Host networking (`--network=host`)
- GPU device access (`--device nvidia.com/gpu=all`)
- Security label disabled (`--security-opt=label=disable`)
- Persistent storage mounted (`${HOME}/.ollama:/root/.ollama`)


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
