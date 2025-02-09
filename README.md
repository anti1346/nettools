# ubuntu-nettools

##### 1. Docker Buildx 빌더 생성 및 사용
```
docker buildx inspect --bootstrap || docker buildx create --use
```
##### 2. 멀티 플랫폼 Docker 이미지를 빌드하고 푸시
```
docker buildx build --platform linux/amd64,linux/arm64 \
  --tag anti1346/nettools:1.0.0 --tag anti1346/nettools:latest \
  anti1346/ubuntu2204:nettools --push
```
##### 3. Docker Hub에서 빌드된 이미지 가져오기
```
docker pull anti1346/nettools:1.0.0
```
##### 4. 이미지의 아키텍처 확인
```
docker inspect anti1346/nettools:1.0.0 --format='{{.Architecture}}'
```
##### 5. Docker 컨테이너 실행 (기본 옵션)
```
docker run -it --rm --name nettools -h nettools anti1346/nettools:1.0.0
```
##### 6. Docker 컨테이너 실행 (네트워크 관련 권한 부여)
```
docker run -it --rm --net=host --cap-add net_admin \
  --name nettools anti1346/nettools:1.0.0
```

<details>
<summary>docker build</summary>

##### docker build
```
docker build --tag anti1346/ubuntu-nettools:latest --no-cache .
```
##### docker build arg
```
docker build --tag anti1346/ubuntu-nettools:latest --build-arg SSH_USER=vagrant --build-arg SSH_PASSWORD=vagrant --no-cache .
```
##### docker tag(도커 이미지 태그 이름 변경)
```
docker tag anti1346/ubuntu-nettools:latest anti1346/ubuntu-nettools:latest
```
##### docker push
```
docker push anti1346/ubuntu-nettools:latest
```
##### docker run test
```
docker run -it --rm --name nettools -h nettools anti1346/ubuntu-nettools:latest
```
```
docker run -it --rm --net=host --cap-add net_admin --name nettools anti1346/ubuntu-nettools:latest
```
</details>

