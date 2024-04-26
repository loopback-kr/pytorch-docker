# Pytorch for Asia/Seoul region

Container images for pytorch are available in [loopbackkr's DockerHub repository](https://hub.docker.com/r/loopbackkr/pytorch). This repository is forked from [docker.io/pytorch/pytorch](https://hub.docker.com/r/pytorch/pytorch/)

## Quick start

### Docker pulling

`docker pull loopbackkr/pytorch:latest`

`docker pull loopbackkr/pytorch:2.0.1-cuda11.7-cudnn8-devel`

### Dockerfiling

`FROM loopbackkr/pytorch:latest`

`FROM loopbackkr/pytorch:2.0.1-cuda11.7-cudnn8-devel`

### Build & Push

`docker build -t loopbackkr/pytorch:2.2.2-cuda12.1-cudnn8-devel .`

`docker image push loopbackkr/pytorch:2.2.2-cuda12.1-cudnn8-devel`

## Features

* Use [kakao mirror](https://mirror.kakao.com/) reposistory for apt and pip
* Pretty welcome message with version log
* Colorful bash prompt
* Set region to Asia/Seoul for local time
* Preinstalled vim, git, libGL, lightning, jupyter, tensorboard