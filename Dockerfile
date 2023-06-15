FROM pytorch/pytorch:2.0.0-cuda11.7-cudnn8-devel

# Change default Shell to bash
SHELL ["/bin/bash", "-c"]
# Set environment variables
ENV TZ=Asia/Seoul
ENV PYTHONIOENCODING=UTF-8
ARG DEBIAN_FRONTEND=noninteractive
# Change default prompt color of root to red
RUN sed -i 's|    PS1=\x27${debian_chroot:+(\$debian_chroot)}\\\[\\033\[01;32m\\\]\\u@\\h\\\[\\033\[00m\\\]:\\\[\\033\[01;34m\\\]\\w\\\[\\033\[00m\\\]\\\$ \x27|    PS1=\x27\${debian_chroot:+(\$debian_chroot)}\\\[\\033\[01;31m\\\]\\u@\\h\\\[\\033\[00m\\\]:\\\[\\033\[01;34m\\\]\\w\\\[\\033\[00m\\\]\\\$ \x27|' /root/.bashrc
# Change Ubuntu repository address to Kakao mirror
RUN sed -i "s|http://archive.ubuntu.com|http://mirror.kakao.com|g" /etc/apt/sources.list
RUN sed -i "s|http://security.ubuntu.com|http://mirror.kakao.com|g" /etc/apt/sources.list
# Update public key
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A4B469963BF863CC
# Add Bash config
RUN echo -e "\n\n# Bash prompt" >> /etc/bash.bashrc
RUN echo 'export PS1="\[\e[31m\]tf-docker\[\e[m\] \[\e[33m\]\w\[\e[m\] > "' >> /etc/bash.bashrc
RUN echo 'force_color_prompt=yes' >> /etc/bash.bashrc
# Add Bash alias
RUN echo -e "\n# Alias" >> /etc/bash.bashrc
RUN echo 'alias ll="ls -alh --full-time"' >> /etc/bash.bashrc
RUN echo 'alias cls="clear"' >> /etc/bash.bashrc
# Add welcome message
RUN echo -e "\n# Welcome message" >> /etc/bash.bashrc
RUN echo "echo -e '\x1b[0;91m'" >> /etc/bash.bashrc
RUN echo -e "cat<<TORCH\n\
________        ________                  ______      FROM\n\
___  __ \\____  ____  __/_____________________  /_       RESEARCH TO\n\
__  /_/ /_  / / /_  /  _  __ \\_  ___/  ___/_  __ \\    PRODUCTION\n\
_  ____/_  /_/ /_  /   / /_/ /  /   / /__ _  / / /\n\
/_/     _\\__, / /_/    \\____//_/    \\___/ /_/ /_/     An open source machine learning framework that accelerates the path\n\
        /____/                                        from research prototyping to production deployment.\n\
\n\
TORCH" >> /etc/bash.bashrc
RUN echo "echo -e '\x1b[0;33m'\$(sed -n '/^NAME=/p' /etc/os-release | cut -d '\"' -f 2)'\t'\$(sed -n '/VERSION=/p' /etc/os-release | cut -d '\"' -f 2)" >> /etc/bash.bashrc
RUN echo "echo -e 'Python \t'\$(python -V | cut -d ' ' -f 2)" >> /etc/bash.bashrc
RUN echo "echo -e 'Pip \t'\$(pip -V | cut -d '(' -f 1 | cut -d ' ' -f 2-)" >> /etc/bash.bashrc
RUN echo "echo -e '\t'\$(sed -n '/index-url/p' /etc/pip.conf)" >> /etc/bash.bashrc
RUN echo "echo -e 'PyTorch'\$(pip freeze | grep torch==) | sed 's/torch//' | sed 's| |\n\t|g' | sed 's|==| |g'" >> /etc/bash.bashrc
RUN echo "if command -v nvidia-smi &> /dev/null" >> /etc/bash.bashrc
RUN echo "then" >> /etc/bash.bashrc
RUN echo "    echo -en '\x1b[0;33mCUDA\t' && echo -e \$(nvcc -V) | grep 'Cuda compilation tools' | cut -d ',' -f 3 | sed 's/ V//g' | cut -d ' ' -f 1" >> /etc/bash.bashrc
RUN echo "    echo -e '\tcuDNN '\$(grep '#define CUDNN_' /usr/include/cudnn_version.h | cut -d ' ' -f 3 | sed -z 's/\n//' | sed -z 's/\n/./g') | sed 's/.(CUDNN_MAJOR.//'" >> /etc/bash.bashrc
RUN echo "    echo -e '\x1b[0;32m' && nvidia-smi -L" >> /etc/bash.bashrc
RUN echo "fi" >> /etc/bash.bashrc
RUN echo "echo -e '\x1b[0m'" >> /etc/bash.bashrc
RUN echo -e "\n" >> /etc/bash.bashrc
# Configure default Pypi repository with Kakao mirror
RUN echo -e \
"[global]\n"\
"index-url=https://mirror.kakao.com/pypi/simple/\n"\
"extra-index-url=https://pypi.org/simple/\n"\
"trusted-host=mirror.kakao.com\n"\
    > /etc/pip.conf &&\
    pip install --no-cache-dir -U pip
# Install additional packages
RUN apt update -qq &&\
    apt install -qqy \
        sudo\
        tzdata\
        vim\
        git
# Clean cache
RUN apt clean &&\
    rm -rf /var/lib/apt/lists/*