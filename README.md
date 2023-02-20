# Pytorch for Asia/Seoul region

Container images for pytorch are available in [loopbackkr's DockerHub repository](https://hub.docker.com/r/loopbackkr/pytorch). This repository is forked from [docker.io/pytorch/pytorch](https://hub.docker.com/r/pytorch/pytorch/)

## Quick start

### Docker pulling

`docker pull loopbackkr/pytorch:latest`

`docker pull loopbackkr/pytorch:1.11.0-cuda11.3-cudnn8`

### Dockerfiling

`FROM loopbackkr/pytorch:latest`

`FROM loopbackkr/pytorch:1.11.0-cuda11.3-cudnn8`

## Features

* Use [kakao mirror](https://mirror.kakao.com/) reposistory for apt and pip
* Pretty welcome message with version log
* Colorful bash prompt
* preinstalled vim, git
