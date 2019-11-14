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

```

# Referencias

* https://github.com/wnuken/apache-php56 desde este repo se hizo el fork. Gracias Brian Sanabria!
* https://github.com/docker-library/php/blob/f016f5dc420e7d360f7381eb014ac6697e247e11/5.6/apache/Dockerfile debian:jessie es el base de php:5.6-apache

 
