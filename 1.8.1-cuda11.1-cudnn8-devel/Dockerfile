FROM pytorch/pytorch:1.8.1-cuda11.1-cudnn8-devel

# Change default Shell to bash
SHELL ["/bin/bash", "-c"]


### Set environment variables
# Set Timezone
ENV TZ=Asia/Seoul
# Set X Server remote address
ENV DISPLAY=dev.loopback.kr:0
# Set python encoding type
ENV PYTHONIOENCODING=UTF-8


### Change settings
# Change Timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# Change bash shell prompt color of root account
RUN sed -i 's/    xterm-color) color_prompt=yes;;/    #xterm-color) color_prompt=yes;;\n    xterm-color|*-256color) color_prompt=yes;;/' /root/.bashrc
# Change original green color of bash shell prompt to red color
RUN sed -i 's/    PS1=\x27${debian_chroot:+(\$debian_chroot)}\\\[\\033\[01;32m\\\]\\u@\\h\\\[\\033\[00m\\\]:\\\[\\033\[01;34m\\\]\\w\\\[\\033\[00m\\\]\\\$ \x27/    PS1=\x27\${debian_chroot:+(\$debian_chroot)}\\\[\\033\[01;31m\\\]\\u@\\h\\\[\\033\[00m\\\]:\\\[\\033\[01;34m\\\]\\w\\\[\\033\[00m\\\]\\\$ \x27/' /root/.bashrc
# Change Ubuntu repository address to Kakao server
RUN sed -i 's/archive.ubuntu.com/mirror.loopback.kr/g' /etc/apt/sources.list
RUN sed -i 's/security.ubuntu.com/mirror.loopback.kr/g' /etc/apt/sources.list
RUN sed -i 's/extras.ubuntu.com/mirror.loopback.kr/g' /etc/apt/sources.list


### Install additional packages
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


# Write maintainer information
LABEL maintainer="Hyunseok Lim <hyunseoki@ut.ac.kr>"
