FROM docker.io/fedora:43 as fedora_updated

ARG VERSION

WORKDIR /root

RUN dnf -y update \
    && curl -s -L https://nvidia.github.io/libnvidia-container/stable/rpm/nvidia-container-toolkit.repo -o /etc/yum.repos.d/nvidia-container-toolkit.repo \
    && dnf config-manager setopt nvidia-container-toolkit-experimental.enabled=1 \
    && dnf -y install libseccomp nvtop ncdu nnn nmap-ncat htop \
    && dnf -y install --downloadonly nvidia-container-toolkit nvidia-container-toolkit-base libnvidia-container-tools libnvidia-container1 \
    && rpm -ihv --nodigest --nofiledigest /var/cache/libdnf*/nvidia-container-toolkit-*/packages/*.rpm \
    && dnf -y clean all


FROM fedora_updated as ollama_installed

RUN \
    curl -fsSL https://github.com/ollama/ollama/releases/download/v${VERSION}/ollama-linux-amd64.tgz | tar -xzv -C /usr/local

# This is to support AMD ROCM, 5.6 GiB / 8.6 GiB. Disabling to save space.
# RUN curl -fsSL https://ollama.com/download/ollama-linux-amd64-rocm.tgz | tar -xzv -C /usr/local


FROM ollama_installed as ollama_user_setup

#RUN --network=none \
#    useradd -r -s /bin/false -U -m -d /usr/local/share/ollama ollama \
#    && usermod -a -G ollama $(whoami)

CMD /usr/local/bin/ollama serve
