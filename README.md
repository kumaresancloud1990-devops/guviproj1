🚀 React App CI/CD Pipeline with Docker & Jenkins










📌 Project Overview

This project demonstrates a complete end-to-end CI/CD pipeline for deploying a React application using:

Docker
Jenkins
GitHub
Docker Hub
Uptime Kuma
Amazon Web Services

The pipeline automates:

Build 📦
Push 🚀
Deployment ⚙️
for both Development and Production environments.
🏗️ Architecture
Developer → GitHub → Jenkins → Docker Build → Docker Hub → AWS EC2 → Uptime Kuma
⚙️ Tech Stack
Layer	Technology
Frontend	React (Pre-built)
CI/CD	Jenkins Pipeline
Containerization	Docker
Registry	Docker Hub
Cloud	AWS EC2
Monitoring	Uptime Kuma
📂 Project Structure
.
├── Dockerfile
├── default.conf
├── deploy.sh
├── build.sh
├── Jenkinsfile
├── .dockerignore
├── .gitignore
└── README.md
🐳 Docker Setup
🔹 Build Image
docker build -t reactproj1 .
🔹 Run Container
docker run -d -p 3000:80 reactproj1
🔐 Docker Hub Integration
docker login
docker tag reactproj1 <your-username>/reactproj1-dev
docker push <your-username>/reactproj1-dev
⚙️ Jenkins Pipeline
🔹 Pipeline Workflow
Stage	Description
Checkout	Pull code from GitHub
Docker Login	Authenticate with Docker Hub
Build Image	Build Docker image
Push Image	Push image to registry
Deploy	Run container on server
🔄 CI/CD Flow
🧪 Development Deployment
Push to dev branch
Jenkins builds & pushes image
Deploys to DEV environment
🚀 Production Deployment
Push to main branch
Jenkins builds & pushes image
Deploys to PROD environment
☁️ AWS EC2 Deployment
# Install Docker
sudo apt update
sudo apt install docker.io -y

# Pull image
docker pull <your-username>/reactproj1-prod

# Run container
docker run -d -p 80:80 <your-username>/reactproj1-prod
📊 Monitoring with Uptime Kuma
Monitor application health
Configure alerts:
✅ Application UP
❌ Application DOWN

✔️ Automated CI/CD pipeline
✔️ Dockerized application
✔️ Dev & Prod environment separation
✔️ AWS cloud deployment
✔️ Real-time monitoring with alerts

Kumaresan Vijayakumar
DevOps Engineer
