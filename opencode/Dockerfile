FROM docker.io/fedora:43

# We want the latest versions.
# hadolint ignore=DL3041
RUN dnf update -y && dnf install -y which curl git zip unzip nnn \
        cmake clang-tools-extra shellcheck python3-pylint python3-autopep8 make \
        glow nodejs npm \
        shfmt black uv ruff python3-isort python3-fixit \
        yamllint hadolint python3-ansible-lint csslint rpmlint gitlint \
        ripgrep fzf bat fd-find jq gojq parallel \
        golang rust java-latest-openjdk-devel rust-analyzer \
        ninja-build gcc gcc-c++ gdb cppcheck \
    && dnf clean all

# Install opencode
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN touch /root/.bashrc; curl -fsSL https://opencode.ai/install | bash

ENV PATH="/root/.opencode/bin:${PATH}"

CMD ["/bin/bash"]
