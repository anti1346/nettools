FROM ubuntu:22.04

LABEL website="sangchul.kr"

ARG DEBIAN_FRONTEND=noninteractive
ARG SSH_ROOT_PASSWORD=${SSH_ROOT_PASSWORD:-root}
ARG SSH_USER=${SSH_USER:-ubuntu}
ARG SSH_PASSWORD=${SSH_PASSWORD:-ubuntu}

ENV SSH_ROOT_PASSWORD=${SSH_ROOT_PASSWORD}
ENV SSH_USER=${SSH_USER}
ENV SSH_PASSWORD=${SSH_PASSWORD}

USER root

RUN sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list \
    && apt-get update -qq \
    && apt-get install -qq -y \
        arping telnet inetutils-ping netcat apt-utils sudo dialog \
        net-tools traceroute dnsutils \
        ethtool tcpdump ipcalc \
        curl wget vim \
#         sudo git make \
    && apt-get clean -qq autoclean \
    && apt-get autoremove -qq --yes \
    && rm -rf /var/lib/apt/lists /var/lib/dpkg/info /tmp/* /var/tmp/*
    
RUN echo "root:$SSH_ROOT_PASSWORD" | chpasswd \
  && echo 'export PS1="\[\e[33m\]\u\[\e[m\]\[\e[37m\]@\[\e[m\]\[\e[34m\]\h\[\e[m\]:\[\033[01;31m\]\W\[\e[m\]$ "' >> ~/.bashrc

RUN useradd -rm -d /home/$SSH_USER -s /bin/bash -G sudo $SSH_USER \
  && mkdir -m 700 /home/$SSH_USER/.ssh \
  && echo "$SSH_USER":"$SSH_PASSWORD" | chpasswd \
  && echo "$SSH_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
  
WORKDIR /root

CMD ["/bin/bash"]





###docker build
# docker build --tag anti1346/ubuntu-nettools:latest --no-cache .
