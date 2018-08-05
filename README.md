# Tensorflow DIY

A [Docker](http://docker.com) file to build images for AMD & ARM devices with [Tensorflow](https://www.tensorflow.org/) an open source software library for numerical computation using data flow graphs.
With this file you will be able to change the base image (default Ubuntu), the python version (default Python3) and the tensorflow wheel file.

> Be aware! You should read carefully the usage documentation of every tool!

## Details

- [GitHub](https://github.com/DeftWork/tensorflow-diy)
- [Docker Hub](https://hub.docker.com/r/elswork/tensorflow-diy/)
- [Deft.Work my personal blog](http://deft.work/tensorflow_for_raspberry)

## Build Instructions

Build for amd64 architecture python3

```sh
docker build -t elswork/tensorflow-diy:latest .
```

Build for amd64 architecture python2

```sh
docker build -t elswork/tensorflow-diy:latest-py2 --build-arg PY_VER= .
```

Build for amd64 architecture changing the base image to debian

```sh
docker build -t elswork/tensorflow-diy:debian-stretch \
 --build-arg BASE_IMG=debian:stretch
```

Build for arm32v7 architecture python3

```sh
docker build -t elswork/tensorflow-diy:arm32v7 \
 --build-arg WHL_FILE=https://www.piwheels.org/simple/tensorflow/tensorflow-1.9.0-cp35-none-linux_armv7l.whl .
```

Build for arm32v7 architecture python2

```sh
docker build -t elswork/tensorflow-diy:arm32v7-py2 \
 --build-arg PY_VER= WHL_FILE=https://www.piwheels.org/simple/tensorflow/tensorflow-1.9.0-cp27-none-linux_armv7l.whl .
```

## My Real Usage Example

In order everyone could take full advantages of the usage of this docker container, I'll describe my own real usage setup.
For arm32v7 architecture replace latest by arm32v7 tag.

```sh
docker run -it elswork/tensorflow-diy:latest
```