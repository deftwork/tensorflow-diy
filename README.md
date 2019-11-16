# Tensorflow DIY

A [Docker](http://docker.com) file to build images for AMD & ARM devices with [Tensorflow](https://www.tensorflow.org/) an open source software library for numerical computation using data flow graphs.

> Be aware! You should read carefully the usage documentation of every tool!

## Details

You will be able to choose the Tensorflow versión by choosing version tags:
- 1.14.0 (latest)
- 1.13.1
- 1.12.0
- ...

This is a [Multi-Arch](https://blog.docker.com/2017/11/multi-arch-all-the-things/) image, so you don't have to specify the target architecture because it will provide the suitable one (ARMV7/x86_64).

Despite Tensorflow is full functional in this image there are a lot of complementary tools missing, so I use it as base image for more complex images with some of this complementary tools.

This image is the base image for a set of images [Tensorflow Data Science Docker Stack](https://gist.github.com/elswork/863053972ffb86f036c0bf4fb6c7e691)

- [Deft.Work my personal blog](http://deft.work/tensorflow_for_raspberry)

| Docker Hub | Docker Pulls | Docker Stars | Docker Build | Size/Layers |
| --- | --- | --- | --- | --- |
| [tensorflow-diy](https://hub.docker.com/r/elswork/tensorflow-diy "elswork/tensorflow-diy on Docker Hub") | [![](https://img.shields.io/docker/pulls/elswork/tensorflow-diy.svg)](https://hub.docker.com/r/elswork/tensorflow-diy "tensorflow-diy on Docker Hub") | [![](https://img.shields.io/docker/stars/elswork/tensorflow-diy.svg)](https://hub.docker.com/r/elswork/tensorflow-diy "tensorflow-diy on Docker Hub") | [![](https://img.shields.io/docker/build/elswork/tensorflow-diy.svg)](https://hub.docker.com/r/elswork/tensorflow-diy "tensorflow-diy on Docker Hub") | [![](https://images.microbadger.com/badges/image/elswork/tensorflow-diy.svg)](https://microbadger.com/images/elswork/tensorflow-diy "tensorflow-diy on microbadger.com") |

[![HitCount](http://hits.dwyl.io/DeftWork/tensorflow-diy.svg)](http://hits.dwyl.io/DeftWork/tensorflow-diy)

## Latest Enhancements
- Upgrade Ubuntu version to 16.04
- Upgrade Pyhton version to 3.5
- Retired Python 2.7 version

## Build Instructions

Build for amd64 architecture python3

```sh
docker build -t tensorflow-diy .
```

## Run Image

```sh
docker run -it elswork/tensorflow-diy:latest
```
