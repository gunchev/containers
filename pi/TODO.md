# Pi container TODO

TODO list:

- [x] Restore `rpmlint`, `mock`, `rpmdevtools` after Fedora 44 selinux
      dep chain was fixed by dropping `--exclude container-selinux`.
- [x] Add `make prune` / `make clean-all` to recover dangling images
      and volumes after iterative builds.
- [x] Seed `~/.pi/agent/settings.json` (via `/etc/skel`) with
      `autoupdate=false`, `enableInstallTelemetry=false`,
      `defaultProjectTrust="never"`, plus `PI_SKIP_VERSION_CHECK=1` /
      `PI_TELEMETRY=0` / `PI_OFFLINE=0` env vars in the Containerfile.
- [x] Set OCI labels (`org.opencontainers.image.title=pi`,
      `source`, `url`, `documentation=vendor=dgunchev`,
      `licenses=Unlicense`) so the registry listing differentiates this
      image from `fedora:44`.
- [x] Resolve host-side NVIDIA kernel/userspace mismatch.
      Symptom was: `toolbox enter pi-toolbox` (and any `podman run`
      with the nvidia CDI hook) failing with
      `Error: the proprietary NVIDIA driver's kernel and user space don't match`.
      Root cause: `nvidia-driver` upgraded to 610.43.03 on the host but
      the running kernel held the prior 610.43.02 module loaded at boot.
      Fix on the host (not in this image): `sudo rmmod nvidia_uvm
      nvidia_drm nvidia_modeset nvidia && sudo modprobe nvidia`.
      Verify with `nvidia-smi` reporting the loaded driver version.
- [ ] Decide on keeping a pre-built `pi-linux-x64.tar.gz` / `pi-linux-arm64.tar.gz`
      fallback lane for faster / smaller images in environments where
      `pi install npm:...` and authoring extensions are not needed.
- [ ] Re-evaluate the persistent mounts. `~/.pi/agent` covers the bulk
      of state; `~/.config/pi` and `~/.local/share/pi` are intentionally
      kept for parity with the opencode container. Drop them if Pi
      itself stops recommending them.
- [ ] Consider `make ci` target that builds, tests and lints in one go
      so it can be wired into GitHub Actions / pre-commit.
- [ ] Wire an `akmods`/`dracut` post-transaction hook on the host so
      `nvidia-driver` upgrades force a kmod rebuild before the next
      reboot (avoid repeat of the 610.43.02-vs-610.43.03 mismatch).
- [ ] Pin / lock OpenCode's `make test` recipe to match our hardened one
      (`--userns=keep-id`, no `-it`, nested podman probe).
