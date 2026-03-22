# #!/bin/bash

# IMAGE=kumaresancloud1990/dev-react-app:latest

# echo "Pulling latest image..."
# docker pull $IMAGE

# echo "Stopping old container..."
# docker stop react-app || true
# docker rm react-app || true

# echo "Running new container..."
# docker run -d -p 8080:80 --name react-app $IMAGE
#!/bin/bash

IMAGE=$1

# Stop old container if exists
docker stop react-app || true
docker rm react-app || true

# Run new container
docker run -d --name react-app -p 80:80 $IMAGE