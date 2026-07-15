FROM ubuntu:26.04

# Remove the pre-existing ubuntu user and group
RUN touch /var/mail/ubuntu && chown ubuntu /var/mail/ubuntu && \
    userdel -r ubuntu || true && \
    groupdel ubuntu || true

ARG DEBIAN_FRONTEND=noninteractive
ARG USERNAME=syize
ARG USER_UID=1000
ARG USER_GID=1000
ARG ONEAPI_COMPILER_VERSION=2023.2.4
ARG ONEAPI_MPI_VERSION=2021.18

ENV TZ=Asia/Shanghai
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV SHELL=/bin/bash
ENV PATH=/opt/local/apps/bin:${PATH}

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https \
    bash \
    build-essential \
    ca-certificates \
    cmake \
    curl \
    gfortran \
    git \
    git-lfs \
    gnupg \
    less \
    libaec-dev \
    libc6-dev \
    libcurl4-openssl-dev \
    libfftw3-bin \
    libfftw3-dev \
    libfftw3-mpi-dev \
    libgdal-dev \
    libgeotiff-dev \
    # libgrib2c-dev \
    libjpeg-dev \
    libncarg-bin \
    libncarg-dev \
    libpng-dev \
    libssl-dev \
    libx11-dev \
    libxml2-dev \
    locales \
    lmod \
    openssh-client \
    openssh-server \
    openssh-sftp-server \
    python3 \
    python3-dev \
    python3-pip \
    python3-venv \
    rsync \
    software-properties-common \
    sudo \
    tzdata \
    vim \
    wget \
    zip \
    unzip \
    && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8

COPY configs/apt/oneAPI.list /etc/apt/sources.list.d/oneAPI.list

RUN mkdir -p /usr/share/keyrings \
    && wget -qO- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB \
        | gpg --dearmor -o /usr/share/keyrings/oneapi-archive-keyring.gpg \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        intel-oneapi-common-vars \
        intel-oneapi-compiler-dpcpp-cpp-and-cpp-classic-${ONEAPI_COMPILER_VERSION} \
        intel-oneapi-compiler-fortran-${ONEAPI_COMPILER_VERSION} \
        intel-oneapi-mpi-${ONEAPI_MPI_VERSION} \
        intel-oneapi-mpi-devel-${ONEAPI_MPI_VERSION} \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd --gid "${USER_GID}" "${USERNAME}" \
    && useradd --uid "${USER_UID}" --gid "${USER_GID}" -m -s /bin/bash "${USERNAME}" \
    && usermod -aG sudo "${USERNAME}" \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/${USERNAME}" \
    && echo 'Defaults secure_path="/home/syize/.local/bin:/opt/local/apps/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"' > /etc/sudoers.d/secure-path \
    && chmod 0440 "/etc/sudoers.d/${USERNAME}" /etc/sudoers.d/secure-path

RUN mkdir -p \
    /var/run/sshd \
    /home/${USERNAME}/Apps \
    /home/${USERNAME}/.config \
    /home/${USERNAME}/.local \
    /opt/local/apps \
    /workspace \
    && chown -R "${USERNAME}:${USERNAME}" \
        /home/${USERNAME} \
        /opt/local/apps \
        /workspace

COPY configs/bashrc.sh /home/${USERNAME}/.bashrc
COPY configs/ssh/public_key /tmp/${USERNAME}_authorized_key
COPY configs/ssh/start-sshd.sh /usr/local/bin/start-sshd.sh
COPY configs/shell/modulepath.sh /etc/profile.d

RUN printf '\n%s\n' \
    '# System environment for module and Intel oneAPI.' \
    'export PATH=/opt/local/apps/bin:$PATH' \
    'if [ -f /usr/share/lmod/lmod/init/bash ]; then source /usr/share/lmod/lmod/init/bash; fi' \
    >> /home/${USERNAME}/.bashrc \
    && chown "${USERNAME}:${USERNAME}" /home/${USERNAME}/.bashrc

RUN mkdir -p /home/${USERNAME}/.ssh \
    && cat /tmp/${USERNAME}_authorized_key > /home/${USERNAME}/.ssh/authorized_keys \
    && chown -R "${USERNAME}:${USERNAME}" /home/${USERNAME}/.ssh \
    && chmod 700 /home/${USERNAME}/.ssh \
    && chmod 600 /home/${USERNAME}/.ssh/authorized_keys \
    && rm -f /tmp/${USERNAME}_authorized_key

RUN chmod 755 /usr/local/bin/start-sshd.sh

RUN git lfs install --system

RUN sed -ri 's/^#?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && sed -ri 's/^#?PubkeyAuthentication .*/PubkeyAuthentication yes/' /etc/ssh/sshd_config \
    && sed -ri 's@^#?AuthorizedKeysFile .*@AuthorizedKeysFile .ssh/authorized_keys@' /etc/ssh/sshd_config \
    && sed -ri 's/^#?PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config \
    && printf '\n%s\n%s\n' \
        'HostKey /etc/ssh/keys/ssh_host_rsa_key' \
        'HostKey /etc/ssh/keys/ssh_host_ed25519_key' \
        >> /etc/ssh/sshd_config \
    && sed -ri 's@^session\s+required\s+pam_loginuid.so@session optional pam_loginuid.so@' /etc/pam.d/sshd

USER ${USERNAME}
ENV PATH=/home/${USERNAME}/.local/bin:/opt/local/apps/bin:${PATH}
RUN mkdir -p /home/syize/Downloads \
    /home/syize/Documents \
    /home/syize/Temp
WORKDIR /workspace

VOLUME ["/home/syize/.config", "/home/syize/.local", "/home/syize/Apps", "/opt/local/apps"]

CMD ["/bin/bash"]
