pipeline {
    agent any

    environment {
        DOCKERHUB_CREDS = '2a719a61-c076-4d60-9042-d232ed6ffa1d'
        DEV_IMAGE = "kumaresankarana/reactproj1-dev"
        PROD_IMAGE = "kumaresankarana/reactproj1-prod"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Get Branch Name') {
            steps {
                script {
                    env.GIT_BRANCH_NAME = sh(
                        script: "git rev-parse --abbrev-ref HEAD",
                        returnStdout: true
                    ).trim()
                    echo "Current Branch: ${env.GIT_BRANCH_NAME}"
                }
            }
        }

        stage('Docker Login') {
            steps {
                echo "Logging in to Docker Hub..."
                withCredentials([usernamePassword(
                    credentialsId: DOCKERHUB_CREDS,
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS'
                )]) {
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                }
            }
        }

        // ================= DEV =================
        stage('Build & Push DEV') {
            when {
                expression { env.GIT_BRANCH_NAME == 'dev' }
            }
            steps {
                echo "Building DEV image..."
                sh "docker build -t $DEV_IMAGE:latest ."

                echo "Pushing DEV image..."
                sh "docker push $DEV_IMAGE:latest"
            }
        }

        stage('Deploy DEV') {
            when {
                expression { env.GIT_BRANCH_NAME == 'dev' }
            }
            steps {
                echo "Deploying DEV..."
                sh "./deploy.sh $DEV_IMAGE:latest"
            }
        }

        // ================= PROD =================
        stage('Build & Push PROD') {
            when {
                expression { env.GIT_BRANCH_NAME == 'main' }
            }
            steps {
                echo "Building PROD image..."
                sh "docker build -t $PROD_IMAGE:latest ."

                echo "Pushing PROD image..."
                sh "docker push $PROD_IMAGE:latest"
            }
        }

        stage('Deploy PROD') {
            when {
                expression { env.GIT_BRANCH_NAME == 'main' }
            }
            steps {
                echo "Deploying PROD..."
                sh "./deploy.sh $PROD_IMAGE:latest"
            }
        }
    }

    post {
        always {
            echo "Cleaning up Docker images..."
            sh "docker rmi -f $DEV_IMAGE:latest || true"
            sh "docker rmi -f $PROD_IMAGE:latest || true"
        }
    }
}