# ubuntu-nettools

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
