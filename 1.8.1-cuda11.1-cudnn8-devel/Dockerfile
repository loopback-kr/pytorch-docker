FROM pytorch/pytorch:1.8.1-cuda11.1-cudnn8-devel

# Change default Shell to bash
SHELL ["/bin/bash", "-c"]

# Set python encoding type
ENV PYTHONIOENCODING=UTF-8
# Set X Server address
ENV DISPLAY=dev.amilab.dev:0

# Change Ubuntu repository address to DaumKaKao
RUN sed -i 's/archive.ubuntu.com/mirror.loopback.kr/g' /etc/apt/sources.list

# Install essential packages
RUN apt update \
    && apt install -y \
        git \
        vim \
        tree \
        wget \
        zip \
        unzip \
        libglu1-mesa-dev \
        libglib2.0-0 \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# Configure default Pypi repository address and default progress bar style
RUN mkdir ~/.pip \
    && echo -e \
"[global]\n"\
"index-url=http://mirror.loopback.kr/pypi/simple/\n"\
"trusted-host=mirror.loopback.kr\n"\
"progress-bar=emoji"\
        > ~/.pip/pip.conf \
    && pip install -U pip

# Add alias
RUN alias l="ls -alh --full-time" && \
    alias cls='clear'

# Write maintainer information
LABEL maintainer="Hyunseok Lim <hyunseoki@ut.ac.kr>"
