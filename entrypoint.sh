#!/bin/bash

# root 및 ubuntu 사용자 비밀번호 설정
if [ -n "$SSH_ROOT_PASSWORD" ]; then
  echo "root:$SSH_ROOT_PASSWORD" | chpasswd
fi

if [ -n "$SSH_PASSWORD" ]; then
  echo "ubuntu:$SSH_PASSWORD" | chpasswd
fi

# SSH 서버 시작
/usr/sbin/sshd

# 제공된 명령 실행
exec "$@"
