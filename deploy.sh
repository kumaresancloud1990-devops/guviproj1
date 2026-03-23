#!/bin/bash

IMAGE_NAME=$1

echo "Stopping old container..."
docker rm -f react-app || true

echo "Pulling latest image..."
docker pull $IMAGE_NAME

echo "Running new container..."
docker run -d -p 80:80 --name react-app $IMAGE_NAME