# Tensorflow DIY

A [Docker](http://docker.com) file to build images for AMD & ARM devices with [Tensorflow](https://www.tensorflow.org/) an open source software library for numerical computation using data flow graphs.
With this file you will be able to choose the python version (default Python3) and the tensorflow wheel file.

> Be aware! You should read carefully the usage documentation of every tool!

## Details

- [Deft.Work my personal blog](http://deft.work/tensorflow_for_raspberry)

| Docker Hub | Docker Pulls | Docker Stars | Docker Build | Size/Layers |
| --- | --- | --- | --- | --- |
| [tensorflow-diy](https://hub.docker.com/r/elswork/tensorflow-diy "elswork/tensorflow-diy on Docker Hub") | [![](https://img.shields.io/docker/pulls/elswork/tensorflow-diy.svg)](https://hub.docker.com/r/elswork/tensorflow-diy "tensorflow-diy on Docker Hub") | [![](https://img.shields.io/docker/stars/elswork/tensorflow-diy.svg)](https://hub.docker.com/r/elswork/tensorflow-diy "tensorflow-diy on Docker Hub") | [![](https://img.shields.io/docker/build/elswork/tensorflow-diy.svg)](https://hub.docker.com/r/elswork/tensorflow-diy "tensorflow-diy on Docker Hub") | [![](https://images.microbadger.com/badges/image/elswork/tensorflow-diy.svg)](https://microbadger.com/images/elswork/tensorflow-diy "tensorflow-diy on microbadger.com") |

This image is the base image for a set of images [Data Science Docker Stacks](https://goo.gl/qvx7Vv)

## Build Instructions

Build for amd64 architecture python3

```sh
docker build -t elswork/tensorflow-diy:latest .
```

Build for amd64 architecture python2

```sh
docker build -t elswork/tensorflow-diy:latest-py2 --build-arg PY_VER= .
```

Build for arm32v7 architecture python3

```sh
docker build -t elswork/tensorflow-diy:latest \
 --build-arg WHL_FILE=https://www.piwheels.org/simple/tensorflow/tensorflow-1.9.0-cp35-none-linux_armv7l.whl .
```

Build for arm32v7 architecture python2

```sh
docker build -t elswork/tensorflow-diy:latest-py2 \
 --build-arg PY_VER= \
 --build-arg WHL_FILE=https://www.piwheels.org/simple/tensorflow/tensorflow-1.9.0-cp27-none-linux_armv7l.whl .
```

## My Real Usage Example

In order everyone could take full advantages of the usage of this docker container, I'll describe my own real usage setup.
Python3 flavour for amd64 or arm32v7 architecture (thanks to its [Multi-Arch](https://blog.docker.com/2017/11/multi-arch-all-the-things/) base image)

```sh
docker run -it elswork/tensorflow-diy:latest
```

Python2 flavour for amd64 or arm32v7 architecture

```sh
docker run -it elswork/tensorflow-diy:latest-py2
```
