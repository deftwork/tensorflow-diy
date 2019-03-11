ARG BASEIMAGE=ubuntu:16.04
FROM ${BASEIMAGE}

ARG PY_VER=3
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
ARG TFVERSION
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
    libatlas-base-dev \
    python$PY_VER-dev python$PY_VER-pip python$PY_VER-h5py && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p $HOME/.config/pip && \
    touch $HOME/.config/pip/pip.conf && \
    echo "[global]" >> $HOME/.config/pip/pip.conf && \
    echo "extra-index-url=https://www.piwheels.org/simple" >> $HOME/.config/pip/pip.conf

ARG WHL_FILE=tensorflow==$TFVERSION

RUN python$PY_VER -m pip install --upgrade pip setuptools && \
    pip$PY_VER --no-cache-dir install --user --upgrade $WHL_FILE 

