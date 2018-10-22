FROM ubuntu:16.04

ARG PY_VER=3
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL mantainer="Eloy Lopez <elswork@gmail.com>" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="tensorflow-diy" \
    org.label-schema.description="Customizable Tensorflow for amd64 and arm32v7" \
    org.label-schema.url="https://deft.work" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/DeftWork/tensorflow-diy" \
    org.label-schema.vendor="Deft Work" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0"

RUN apt-get update && apt-get install -y --no-install-recommends \
    libatlas-base-dev python$PY_VER-h5py \
    python$PY_VER python$PY_VER-dev python$PY_VER-pip python$PY_VER-setuptools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ARG WHL_FILE=tensorflow==1.11.0

RUN python$PY_VER -m pip install --upgrade pip && \
    pip$PY_VER --no-cache-dir install $WHL_FILE  