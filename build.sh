#!/bin/bash

APP_NAME=react-app
DEV_REPO=yourdockerhub/dev-react-app

echo "Building Docker Image..."
docker build -t $APP_NAME .

echo "Tagging Image..."
docker tag $APP_NAME $DEV_REPO:latest

echo "Pushing to Docker Hub..."
docker push $DEV_REPO:latest
