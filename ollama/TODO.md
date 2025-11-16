# OpenCode container TODO

## TOP
- [ ] Create non-root user in container instead of running as root

## Improvements

### Critical Issues
- [ ] Add checksum verification for all downloads (nvidia repo, ollama binary). Upstream problem.
- [ ] Fix fragile wildcard path in Containerfile:12 for nvidia packages (solved by the previous one)

### Security Improvements
- [ ] Add integrity checks for all external downloads
- [ ] Consider alternatives to --network=host for better isolation
- [ ] Review --security-opt=label=disable necessity

### Efficiency Optimizations
- [x] Combine Containerfile RUN layers for smaller image size
- [x] Add .dockerignore file to exclude unnecessary files
- [ ] Optimize base image by removing unnecessary packages

### Documentation Fixes
- [ ] Replace placeholder <repository-url> in README.md
- [ ] Standardize VERSION vs TAG terminology across documentation
- [ ] Clarify NVIDIA driver prerequisites

### Missing Features
- [ ] Add health check endpoints to container
