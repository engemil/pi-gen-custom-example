FROM debian:bullseye

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

RUN apt-get -y update && \
    apt-get -y install --no-install-recommends \
        git vim parted \
        quilt coreutils qemu-user-static debootstrap zerofree zip dosfstools e2fsprogs\
        libarchive-tools libcap2-bin rsync grep udev xz-utils curl xxd file kmod bc \
        binfmt-support ca-certificates fdisk gpg pigz arch-test

#RUN apt install -y bmap-tools

# Set up ARM emulation for cross-compilation
# This registers ARM emulation with binfmt_misc inside the container
RUN dpkg --add-architecture armhf && \
    dpkg --add-architecture arm64

# Create a startup script to initialize binfmt_misc
RUN echo '#!/bin/bash\n\
# Initialize binfmt_misc for ARM emulation\n\
if [ ! -f /proc/sys/fs/binfmt_misc/status ]; then\n\
    mount -t binfmt_misc binfmt_misc /proc/sys/fs/binfmt_misc 2>/dev/null || true\n\
fi\n\
\n\
# Register ARM emulation if not already present\n\
if [ ! -f /proc/sys/fs/binfmt_misc/qemu-arm ]; then\n\
    update-binfmts --enable qemu-arm 2>/dev/null || true\n\
    update-binfmts --enable qemu-aarch64 2>/dev/null || true\n\
fi\n\
\n\
# Execute the original command\n\
exec "$@"\n' > /usr/local/bin/init-binfmt.sh && \
    chmod +x /usr/local/bin/init-binfmt.sh

# Clean up
RUN rm -rf /var/lib/apt/lists/*

# Clone pi-get repository
#RUN git clone https://github.com/RPI-Distro/pi-gen.git /opt/pi-gen

# Make workspace directory
RUN mkdir /workspace

#WORKDIR /workspace
# NB! If you are using devcontainer (with devcontainer.json), changes made inside here (Dockerfile)
# are useless. Since they get written over by that the devcontainer file, which also set up a workspace folder.

