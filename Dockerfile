#ARG BASE_IMG=ubuntu:16.04
FROM ubuntu:16.04

LABEL mantainer="Eloy Lopez <elswork@gmail.com>"
ARG PY_VER=3

RUN apt-get update && apt-get install -y --no-install-recommends \
    libatlas-base-dev \
    python$PY_VER python$PY_VER-dev python$PY_VER-pip python$PY_VER-setuptools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ARG WHL_FILE=tensorflow

RUN python$PY_VER -m pip install --upgrade pip && \
    pip$PY_VER --no-cache-dir install $WHL_FILE  