FROM ubuntu:24.04

LABEL maintainer="sangchul.kr"
LABEL description="Network Tools Container with SSH and Custom User Support"

ARG DEBIAN_FRONTEND=noninteractive

# 필수 패키지 설치
RUN apt-get update \
  && apt-get install -y \
    arping telnet inetutils-ping netcat-openbsd \
    apt-utils sudo dialog \
    net-tools traceroute dnsutils \
    ethtool tcpdump ipcalc \
    curl wget vim openssh-server \
    # sudo git make \
  && apt-get clean autoclean \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/* /var/lib/dpkg/info /tmp/* /var/tmp/*

# SSH 설정
RUN mkdir -p /var/run/sshd \
  && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# 사용자 생성 및 기본 권한 부여
RUN if ! id -u ubuntu 2>/dev/null; then \
      useradd -rm -d /home/ubuntu -s /bin/bash -G sudo ubuntu; \
    fi \
  && mkdir -p /home/ubuntu/.ssh \
  && chmod 700 /home/ubuntu/.ssh \
  && echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# 엔트리포인트 스크립트 복사 및 실행 권한 부여
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /root

ENTRYPOINT ["entrypoint.sh"]
CMD ["/bin/bash"]
