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


