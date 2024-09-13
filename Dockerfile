FROM tensorflow/tensorflow:2.10.1-gpu

RUN apt-get update \
 && export TZ="America/New_York" \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y keyboard-configuration \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y locales \
 && ln -fs "/usr/share/zoneinfo/$TZ" /etc/localtime \
 && dpkg-reconfigure --frontend noninteractive tzdata \
 && apt-get clean

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
 lsb-release \
 libgl1-mesa-dri

ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg-reconfigure locales

# install the basics
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
 vim \
 tmux \
 cmake \
 gcc \
 g++ \
 git \
 build-essential \
 sudo \
 wget \
 curl \
 zip \
 unzip \
 libgl1 


# add a user
ARG user_id
ARG USER dtc
RUN useradd -U --uid ${user_id} -ms /bin/bash $USER \
 && echo "$USER:$USER" | chpasswd \
 && adduser $USER sudo \
 && echo "$USER ALL=NOPASSWD: ALL" >> /etc/sudoers.d/$USER

USER $USER
WORKDIR /home/$USER

RUN pip3 install opencv-python scipy matplotlib scikit-image
