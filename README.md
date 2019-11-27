# README

# Crear tu imagen

```bash
git clone https://github.com/CesarBallardini/apache-php56
cd apache-php56/
git checkout dev

# si no hay proxy en la estacion de trabajo:
time docker build .

# si hay proxy en la estacion de trabajo:
time docker build  --build-arg https_proxy=$http_proxy --build-arg http_proxy=$http_proxy --build-arg no_proxy=$no_proxy   . 

# autentica contra tu cuenta en Docker hub
cat ~/.docker_password.txt | docker login --username cesarballardini --password-stdin

# etiqueta para enviar a Docker hub
IMAGE_NAME=cesarballardini/apache-php56
TAG=1.1
docker build -t ${IMAGE_NAME}:${TAG} -t ${IMAGE_NAME}:latest .

# Ver los tags de las imagenes locales:
docker images  --format="{{ .ID }}" \
  | sort | uniq | xargs docker inspect \
  | jq -r '.[] | [ .Id, (.RepoTags | join(",")) ] | @csv'


# envia la imagen al hub
docker push ${IMAGE_NAME}:${TAG}
docker push ${IMAGE_NAME}:latest


```

# Referencias

* https://hub.docker.com/repository/docker/cesarballardini/apache-php56 la imagen en Docker hub

* https://github.com/wnuken/apache-php56 desde este repo se hizo el fork. Gracias Brian Sanabria!
* https://github.com/docker-library/php/blob/f016f5dc420e7d360f7381eb014ac6697e247e11/5.6/apache/Dockerfile debian:jessie es el base de php:5.6-apache

 
