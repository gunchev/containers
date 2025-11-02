FROM docker.io/archlinux

RUN pacman -Sy --noconfirm zip unzip mc nnn htop netcat && \
    pacman -Scc --noconfirm

RUN touch /root/.bashrc; curl -fsSL https://opencode.ai/install | bash

ENV PATH="/root/.opencode/bin:${PATH}"

CMD ["/bin/bash"]
