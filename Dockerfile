FROM rockylinux:9.3

ENV IMAGE_VERSION=9.3

LABEL maintainer="Kirill Shtrykov" \
      org.opencontainers.image.version=${IMAGE_VERSION} \
      org.opencontainers.image.title="kirillshtrykov/rockylinux-ansible" \
      org.opencontainers.image.description="Rocky Linux Docker container for Ansible roles testing." \
      org.opencontainers.image.url="https://hub.docker.com/r/kirillshtrykov/rockylinux-ansible" \
      org.opencontainers.image.vendor="Kirill Shtrykov" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.source="https://github.com/kirill-shtrykov/docker-rockylinux-ansible"

# Install systemd -- See https://hub.docker.com/_/centos/
RUN rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*;

# Install requirements.
RUN dnf makecache && \
    dnf --assumeyes install \
      python \
      python-pip \
      bash \
      iproute \
      systemd \
      sudo && \
    dnf clean all

# Upgrade pip to latest version.
RUN pip3 install --upgrade pip

# Disable requiretty.
RUN /usr/bin/sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/' /etc/sudoers

VOLUME ["/sys/fs/cgroup"]

CMD ["/usr/sbin/init"]
