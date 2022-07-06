FROM pytorch/pytorch:1.7.1-cuda11.0-cudnn8-devel


### Set environment variables
# Change default Shell to bash
SHELL ["/bin/bash", "-c"]
# Set Timezone
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul
# Set python encoding type
ENV PYTHONIOENCODING=UTF-8
# Set Beep theme
ENV BEEP_MARIO='-f 130 -l 100 -n -f 262 -l 100 -n -f 330 -l 100 -n -f 392 -l 100 -n -f 523 -l 100 -n -f 660 -l 100 -n -f 784 -l 300 -n -f 660 -l 300 -n -f 146 -l 100 -n -f 262 -l 100 -n -f 311 -l 100 -n -f 415 -l 100 -n -f 523 -l 100 -n -f 622 -l 100 -n -f 831 -l 300 -n -f 622 -l 300 -n -f 155 -l 100 -n -f 294 -l 100 -n -f 349 -l 100 -n -f 466 -l 100 -n -f 588 -l 100 -n -f 699 -l 100 -n -f 933 -l 300 -n -f 933 -l 100 -n -f 933 -l 100 -n -f 933 -l 100 -n -f 1047 -l 400'


### Change settings
# Change Timezone
# RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# Change bash shell prompt color of root account
RUN sed -i 's/    xterm-color) color_prompt=yes;;/    #xterm-color) color_prompt=yes;;\n    xterm-color|*-256color) color_prompt=yes;;/' /root/.bashrc
# Change original green color of bash shell prompt to red color
RUN sed -i 's/    PS1=\x27${debian_chroot:+(\$debian_chroot)}\\\[\\033\[01;32m\\\]\\u@\\h\\\[\\033\[00m\\\]:\\\[\\033\[01;34m\\\]\\w\\\[\\033\[00m\\\]\\\$ \x27/    PS1=\x27\${debian_chroot:+(\$debian_chroot)}\\\[\\033\[01;31m\\\]\\u@\\h\\\[\\033\[00m\\\]:\\\[\\033\[01;34m\\\]\\w\\\[\\033\[00m\\\]\\\$ \x27/' /root/.bashrc
# Update PubKey
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A4B469963BF863CC
# Change Ubuntu repository address to Kakao server in Republic of Korea
RUN sed -i 's/^deb http:\/\/archive.ubuntu.com/deb http:\/\/mirror.kakao.com/g' /etc/apt/sources.list
RUN sed -i 's/^deb http:\/\/security.ubuntu.com/deb http:\/\/mirror.kakao.com/g' /etc/apt/sources.list

# Install requirement packages
RUN apt update \
    && apt install -y \
        tzdata \
        beep \
        wget \
        git \
        ca-certificates \
        apt-transport-https \
# Install X11 requirements
        libglu1-mesa-dev \
        libglib2.0-0 \
        libsm6 \
        libxext6 \
        libxrender-dev

# Configure default Pypi repository address and default progress bar style
RUN mkdir -p ~/.config/pip \
    && echo -e \
"[global]\n"\
"index-url=https://mirror.kakao.com/pypi/simple/\n"\
"trusted-host=mirror.kakao.com\n"\
        > ~/.config/pip/pip.conf \
    && pip install -U pip

### Postprocessing & Cleaning
# Add Bash alias
RUN echo 'alias l="ls -alh --full-time"' >> ~/.bashrc
RUN echo 'alias cls="clear"' >> ~/.bashrc
RUN echo 'alias python=python3' >> ~/.bashrc
RUN echo 'alias pip=pip3' >> ~/.bashrc

# Welcome message
RUN echo "echo -e '\x1b[0;91m________        ________                  ______      FROM\n___  __ \\____  ____  __/_____________________  /_        RESEARCH TO\n__  /_/ /_  / / /_  /  _  __ \\_  ___/  ___/_  __ \\    PRODUCTION\n_  ____/_  /_/ /_  /   / /_/ /  /   / /__ _  / / /\n/_/     _\\__, / /_/    \\____//_/    \\___/ /_/ /_/     An open source machine learning framework that accelerates the path from\n        /____/                                        research prototyping to production deployment.\n'" >> ~/.bashrc
RUN echo "echo -e '\x1b[0;33mUbuntu\t'\$(sed -n '/VERSION=/p' /etc/os-release | cut -d '\"' -f 2)" >> ~/.bashrc
RUN echo "echo -e 'Python \t'\$(python -V | cut -d ' ' -f 2)" >> ~/.bashrc
RUN echo "echo -e 'PIP \t'\$(pip -V | cut -d '(' -f 1 | cut -d ' ' -f 2-)" >> ~/.bashrc
RUN echo "echo -e '\t'\$(sed -n '/index-url/p' ~/.config/pip/pip.conf)" >> ~/.bashrc
RUN echo "echo -e -n 'PyTorch' && echo \$(pip freeze | grep torch) | sed 's/torch//' | sed 's/ /\n\t/g' | sed 's/==/ /g'" >> ~/.bashrc
RUN echo "echo -n -e '\x1b[0m'" >> ~/.bashrc

RUN echo "if command -v nvidia-smi &> /dev/null" >> ~/.bashrc
RUN echo "then" >> ~/.bashrc
RUN echo "    echo -e -n '\x1b[0;33mCUDA\t' && echo -e \$(nvcc -V) | grep 'Cuda compilation tools' | cut -d ',' -f 3 | sed 's/ V//g' | cut -d ' ' -f 1" >> ~/.bashrc
RUN echo "    echo -e '\tcuDNN '\$(grep '#define CUDNN_' /usr/include/cudnn_version.h | cut -d ' ' -f 3 | sed -z 's/\n//' | sed -z 's/\n/./g') | sed 's/.(CUDNN_MAJOR.//'" >> ~/.bashrc
RUN echo "    echo -e '\x1b[0;32m' && nvidia-smi -L && echo -e '\x1b[0m'" >> ~/.bashrc
RUN echo "else" >> ~/.bashrc
RUN echo "echo -e -n '\n'" >> ~/.bashrc
RUN echo "fi" >> ~/.bashrc

# Clean the cache
RUN apt clean \
    && rm -rf /var/lib/apt/lists/* \
    && pip cache purge
# Set workspace
WORKDIR /root/workspace