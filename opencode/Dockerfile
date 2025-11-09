FROM docker.io/fedora:43

RUN dnf update -y && dnf install -y which curl git zip unzip nnn \
        cmake clang-tools-extra shellcheck python3-pylint python3-autopep8 make \
        glow nodejs npm yamllint hadolint \
    && dnf clean all

# Install opencode
RUN touch /root/.bashrc; curl -fsSL https://opencode.ai/install | bash

ENV PATH="/root/.opencode/bin:${PATH}"

CMD ["/bin/bash"]
