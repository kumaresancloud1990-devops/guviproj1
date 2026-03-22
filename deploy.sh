#!/bin/bash

IMAGE=yourdockerhub/dev-react-app:latest

echo "Pulling latest image..."
docker pull $IMAGE

echo "Stopping old container..."
docker stop react-app || true
docker rm react-app || true

echo "Running new container..."
docker run -d -p 80:80 --name react-app $IMAGE
