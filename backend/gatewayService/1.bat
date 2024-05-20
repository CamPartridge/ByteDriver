CLS

docker stop gatewayService
docker rm gatewayService
docker rmi gatewayservice:1

docker build --no-cache -t sen300ocelotgatewayapi:1 .
docker run -d -p 5041:8080 --name gatewayService --net netSEN300 sen300ocelotgatewayapi:1