FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
ARG USERNAME=ubuntu

ARG ANDROID_CMDLINE_TOOLS_VERSION=11076708
ARG ANDROID_PLATFORM=android-35
ARG ANDROID_BUILD_TOOLS_VERSION=35.0.0
ARG ANDROID_NDK_VERSION=27.2.12479018

ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV CC=clang
ENV CXX=clang++

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
      | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" \
      > /etc/apt/sources.list.d/nodesource.list \
    && apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    clang \
    clangd \
    cmake \
    curl \
    g++ \
    gcc \
    git \
    gnupg \
    gdb \
    lld \
    lldb \
    libc++-dev \
    libc++abi-dev \
    make \
    ninja-build \
    nodejs \
    nginx \
    openjdk-21-jdk \
    pkg-config \
    python3 \
    python3-dev \
    python3-pip \
    python3-venv \
    software-properties-common \
    sudo \
    unzip \
    wget \
    xz-utils \
    zip \
    && corepack enable \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p ${ANDROID_SDK_ROOT}/cmdline-tools \
    && curl -fsSL "https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_CMDLINE_TOOLS_VERSION}_latest.zip" -o /tmp/android-cmdline-tools.zip \
    && unzip -q /tmp/android-cmdline-tools.zip -d ${ANDROID_SDK_ROOT}/cmdline-tools \
    && mv ${ANDROID_SDK_ROOT}/cmdline-tools/cmdline-tools ${ANDROID_SDK_ROOT}/cmdline-tools/latest \
    && rm -f /tmp/android-cmdline-tools.zip

ENV PATH=${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${ANDROID_SDK_ROOT}/platform-tools:/home/${USERNAME}/.cargo/bin:${PATH}

RUN yes | sdkmanager --licenses >/dev/null \
    && sdkmanager \
      "platform-tools" \
      "platforms;${ANDROID_PLATFORM}" \
      "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" \
      "ndk;${ANDROID_NDK_VERSION}" \
      "cmake;3.22.1"

ENV ANDROID_NDK_HOME=${ANDROID_SDK_ROOT}/ndk/${ANDROID_NDK_VERSION}

RUN mkdir -p /workspace \
    && chown -R ${USERNAME}:${USERNAME} ${ANDROID_SDK_ROOT} /workspace

USER ${USERNAME}
WORKDIR /workspace

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain stable \
    && ~/.cargo/bin/rustup component add rustfmt clippy

EXPOSE 80
CMD ["bash"]
