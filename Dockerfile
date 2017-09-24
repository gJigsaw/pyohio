FROM ubuntu:latest
MAINTAINER PyOhio.Org@JasonGreen.Name
ENV PYOHIO_IMAGE_BUILT_AFTER 20170924-1600

# Update & Upgrade
RUN apt-get update -y \
 && apt-get upgrade -y \
 && apt-get clean

# Code manipulation
RUN apt-get install -y \
    gcc \
    git \
    make

# Editors
RUN apt-get install -y \
    emacs \
    vim

# File transport
RUN apt-get install -y \
    curl \
    wget \
    rsync

# Networking
RUN apt-get install -y \
    host \
    net-tools \
    tcpdump \
    telnet

# Other
RUN apt-get install -y \
    apt-xapian-index \
    build-essential \
    libxml2-dev \
    strace \
    unzip

# Locale
RUN apt-get install -y locales \
 && locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8 \
    LANGUAGE en_US:en \
    LC_ALL en_US.UTF-8

# Python 2
RUN apt-get install -y \
      python \
      python-dev \
      python-distribute \
      python-pip \
      libpq-dev

COPY ./requirements.txt /
RUN pip install -r /requirements.txt

ENV SITE_PATH /site

COPY . ${SITE_PATH}/
ENV LOCAL_SETTINGS_FILE local.py.example
RUN cp ${SITE_PATH}/pyohio/settings/${LOCAL_SETTINGS_FILE} ${SITE_PATH}/pyohio/settings/local.py
WORKDIR ${SITE_PATH}
CMD ${SITE_PATH}/init_then_start
