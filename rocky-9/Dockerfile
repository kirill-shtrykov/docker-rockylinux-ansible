FROM rockylinux/rockylinux:9.0

ENV IMAGE_VERSION=9.0

LABEL maintainer="Kirill Shtrykov" \
      org.opencontainers.image.version=${IMAGE_VERSION} \
      org.opencontainers.image.title="kirillshtrykov/rockylinux-ansible" \
      org.opencontainers.image.description="Rocky Linux Docker container for Ansible roles testing." \
      org.opencontainers.image.url="https://hub.docker.com/r/kirillshtrykov/rockylinux-ansible" \
      org.opencontainers.image.vendor="Kirill Shtrykov" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.source="https://github.com/kirill-shtrykov/docker-rockylinux-ansible"

RUN dnf makecache && \
    dnf --assumeyes install \
      python3 \
      python3-pip \
      bash \
      iproute \
      ca-certificates \
      systemd \
      procps-ng \
      sudo && \
    dnf clean all

# Don't start the optional systemd services.
RUN find /etc/systemd/system \
         /lib/systemd/system \
         -path '*.wants/*' \
         -not -name '*journald*' \
         -not -name '*systemd-tmpfiles*' \
         -not -name '*systemd-user-sessions*' \
         -exec rm {} \;

RUN systemctl set-default multi-user.target

# Disable requiretty.
RUN sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/' /etc/sudoers

VOLUME ["/sys/fs/cgroup"]

ENTRYPOINT ["/usr/lib/systemd/systemd"]
