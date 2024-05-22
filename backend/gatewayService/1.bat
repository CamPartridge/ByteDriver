CLS

docker stop gatewayService
docker rm gatewayService
docker rmi gatewayService:1

docker build --no-cache -t gatewayService:1 .
docker run -d -p 5041:8080 --name gatewayService --net byte_driver_network gatewayService:1