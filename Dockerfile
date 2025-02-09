FROM ubuntu:22.04

LABEL maintainer="sangchul.kr"
LABEL description="Network Tools Container with SSH and Custom User Support"

ARG DEBIAN_FRONTEND=noninteractive

# 기본 환경 변수 설정
ARG SSH_ROOT_PASSWORD=root
ARG SSH_USER=ubuntu
ARG SSH_PASSWORD=ubuntu

# 환경 변수 등록
ENV SSH_ROOT_PASSWORD=${SSH_ROOT_PASSWORD:-root}
ENV SSH_USER=${SSH_USER:-ubuntu}
ENV SSH_PASSWORD=${SSH_PASSWORD:-ubuntu}

USER root

# RUN sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list \
#   && apt-get update \
RUN apt-get update \
  && apt-get install -y \
    arping telnet inetutils-ping netcat \
    apt-utils sudo dialog \
    net-tools traceroute dnsutils \
    ethtool tcpdump ipcalc \
    curl wget vim openssh-server \
    # sudo git make \
  && apt-get clean autoclean \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/* /var/lib/dpkg/info /tmp/* /var/tmp/*

# root 사용자 비밀번호 설정 및 bash 프롬프트 커스터마이징    
RUN echo "root:$SSH_ROOT_PASSWORD" | chpasswd \
  && echo 'export PS1="\[\e[33m\]\u\[\e[m\]\[\e[37m\]@\[\e[m\]\[\e[34m\]\h\[\e[m\]:\[\033[01;31m\]\W\[\e[m\]$ "' >> ~/.bashrc

# 사용자 생성 및 sudo 권한 부여
RUN useradd -rm -d /home/${SSH_USER} -s /bin/bash -G sudo ${SSH_USER} \
  && echo "${SSH_USER}:${SSH_PASSWORD}" | chpasswd \
  && mkdir -p /home/${SSH_USER}/.ssh \
  && chmod 700 /home/${SSH_USER}/.ssh \
  && echo "${SSH_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
  
WORKDIR /root

CMD ["/bin/bash"]





###docker build
# docker build --tag anti1346/ubuntu-nettools:latest --no-cache .
