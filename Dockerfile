FROM pytorch/pytorch:1.11.0-cuda11.3-cudnn8-devel

# Change default Shell to bash
SHELL ["/bin/bash", "-c"]
ENV PYTHONIOENCODING=UTF-8
# Set environment variables
ENV TZ=Asia/Seoul
ENV PYTHONIOENCODING=UTF-8
# Enable color shell prompt of bash
RUN sed -i 's|#force_color_prompt=yes|force_color_prompt=yes|' /root/.bashrc
RUN sed -i 's|#force_color_prompt=yes|force_color_prompt=yes|' ~/.bashrc
# Change default prompt color of root to red
RUN sed -i 's|    PS1=\x27${debian_chroot:+(\$debian_chroot)}\\\[\\033\[01;32m\\\]\\u@\\h\\\[\\033\[00m\\\]:\\\[\\033\[01;34m\\\]\\w\\\[\\033\[00m\\\]\\\$ \x27|    PS1=\x27\${debian_chroot:+(\$debian_chroot)}\\\[\\033\[01;31m\\\]\\u@\\h\\\[\\033\[00m\\\]:\\\[\\033\[01;34m\\\]\\w\\\[\\033\[00m\\\]\\\$ \x27|' /root/.bashrc
# Change Ubuntu repository address to Kakao mirror
RUN sed -i "s|http://archive.ubuntu.com |https://mirror.kakao.com |g" /etc/apt/sources.list
RUN sed -i "s|http://security.ubuntu.com |https://mirror.kakao.com |g" /etc/apt/sources.list
# Update public key
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A4B469963BF863CC
# Add Bash alias
RUN echo 'alias ll="ls -alh --full-time"' >> ~/.bashrc
RUN echo 'alias cls="clear"' >> ~/.bashrc
# Add welcome message
RUN echo "echo -e '\x1b[0;91m________        ________                  ______      FROM\n___  __ \\____  ____  __/_____________________  /_       RESEARCH TO\n__  /_/ /_  / / /_  /  _  __ \\_  ___/  ___/_  __ \\    PRODUCTION\n_  ____/_  /_/ /_  /   / /_/ /  /   / /__ _  / / /\n/_/     _\\__, / /_/    \\____//_/    \\___/ /_/ /_/     An open source machine learning framework that accelerates the path from\n        /____/                                        research prototyping to production deployment.\n'" >> ~/.bashrc
RUN echo "echo -e '\x1b[0;33m'\$(sed -n '/^NAME=/p' /etc/os-release | cut -d '\"' -f 2)'\t'\$(sed -n '/VERSION=/p' /etc/os-release | cut -d '\"' -f 2)" >> ~/.bashrc
RUN echo "echo -e 'Python \t'\$(python -V | cut -d ' ' -f 2)" >> ~/.bashrc
RUN echo "echo -e 'Pip \t'\$(pip -V | cut -d '(' -f 1 | cut -d ' ' -f 2-)" >> ~/.bashrc
RUN echo "echo -e '\t'\$(sed -n '/index-url/p' ~/.config/pip/pip.conf)" >> ~/.bashrc
RUN echo "echo -e 'PyTorch'\$(pip freeze | grep torch) | sed 's/torch//' | sed 's| |\n\t|g' | sed 's|==| |g'" >> ~/.bashrc
RUN echo "if command -v nvidia-smi &> /dev/null" >> ~/.bashrc
RUN echo "then" >> ~/.bashrc
RUN echo "    echo -en '\x1b[0;33mCUDA\t' && echo -e \$(nvcc -V) | grep 'Cuda compilation tools' | cut -d ',' -f 3 | sed 's/ V//g' | cut -d ' ' -f 1" >> ~/.bashrc
RUN echo "    echo -e '\tcuDNN '\$(grep '#define CUDNN_' /usr/include/cudnn_version.h | cut -d ' ' -f 3 | sed -z 's/\n//' | sed -z 's/\n/./g') | sed 's/.(CUDNN_MAJOR.//'" >> ~/.bashrc
RUN echo "    echo -e '\x1b[0;32m' && nvidia-smi -L && echo -e '\x1b[0m'" >> ~/.bashrc
RUN echo "fi" >> ~/.bashrc
# Configure default Pypi repository with Kakao mirror
RUN mkdir -p ~/.config/pip &&\
    echo -e \
"[global]\n"\
"index-url=https://mirror.kakao.com/pypi/simple/\n"\
"extra-index-url=https://pypi.org/simple/\n"\
"trusted-host=mirror.kakao.com\n"\
    > ~/.config/pip/pip.conf &&\
    pip install --no-cache-dir -U pip
# Install additional packages
RUN apt update -qq &&\
    apt install -qqy \
        vim\
        git
# Clean cache
RUN apt clean &&\
    rm -rf /var/lib/apt/lists/*