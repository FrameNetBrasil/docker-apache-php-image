docker build --tag=framenetbrasil/php-fpm:8.3 --no-cache --rm .
docker login -u framenetbrasil
docker push framenetbrasil/php-fpm:8.3


