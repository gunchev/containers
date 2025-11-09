FROM docker.io/archlinux

RUN pacman -Sy --noconfirm curl zip unzip nnn \
        shellcheck python-pylint autopep8 make \
        npm yamllint markdownlint-cli prettier \
    && pacman -Scc --noconfirm

RUN touch /root/.bashrc && curl -fsSL https://opencode.ai/install | bash

ENV PATH="/root/.opencode/bin:${PATH}"

# Install hadolint directly from GitHub releases
RUN \
    curl -fsSL "https://github.com/hadolint/hadolint/releases/latest/download/hadolint-Linux-x86_64" -o /usr/local/bin/hadolint \
    && chmod +x /usr/local/bin/hadolint

# Install vitest globally
RUN npm install -g vitest

CMD ["/bin/bash"]
