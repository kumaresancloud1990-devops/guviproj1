pipeline {
    agent any

    environment {
        DOCKERHUB_CREDS = '2a719a61-c076-4d60-9042-d232ed6ffa1d'
        DEV_REPO = "kumaresankarana/reactproj1-dev"
        PROD_REPO = "kumaresankarana/reactproj1-prod"
    }

    stages {

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: DOCKERHUB_CREDS, usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    // Login to Docker Hub
                    sh "echo $PASS | docker login -u $USER --password-stdin"
                }
            }
        }

        stage('Build Image') {
            steps {
                script {
                    // Build the image and tag it with branch name for clarity
                    def imageTag = "${env.BRANCH_NAME}-latest"
                    sh "docker build -t ${DEV_REPO}:${imageTag} ."
                    env.IMAGE_TAG = imageTag
                }
            }
        }

        stage('Push Image') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'dev') {
                        sh "docker push ${DEV_REPO}:${env.IMAGE_TAG}"
                    } else if (env.BRANCH_NAME == 'main' || env.BRANCH_NAME == 'master') {
                        sh "docker push ${PROD_REPO}:${env.IMAGE_TAG}"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                sh './deploy.sh'
            }
        }
    }

    post {
        always {
            echo "Cleaning up local Docker images..."
            sh "docker rmi -f ${DEV_REPO}:${env.IMAGE_TAG} || true"
            sh "docker rmi -f ${PROD_REPO}:${env.IMAGE_TAG} || true"
        }
    }
}