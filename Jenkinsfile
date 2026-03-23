pipeline {
    agent any

    environment {
        DOCKERHUB_CREDS = '2a719a61-c076-4d60-9042-d232ed6ffa1d'
        DEV_IMAGE = "kumaresankarana/reactproj1-dev"
        PROD_IMAGE = "kumaresankarana/reactproj1-prod"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${DOCKERHUB_CREDS}", usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                }
            }
        }

        stage('Build & Push DEV') {
            when {
                branch 'dev'
            }
            steps {
                script {
                    sh "docker build -t $DEV_IMAGE:$IMAGE_TAG ."
                    sh "docker push $DEV_IMAGE:$IMAGE_TAG"
                }
            }
        }

        stage('Deploy DEV') {
            when {
                branch 'dev'
            }
            steps {
                sh "./deploy.sh $DEV_IMAGE:$IMAGE_TAG"
            }
        }

        stage('Build & Push PROD') {
            when {
                branch 'main'
            }
            steps {
                script {
                    sh "docker build -t $PROD_IMAGE:$IMAGE_TAG ."
                    sh "docker push $PROD_IMAGE:$IMAGE_TAG"
                }
            }
        }

        stage('Deploy PROD') {
            when {
                branch 'main'
            }
            steps {
                sh "./deploy.sh $PROD_IMAGE:$IMAGE_TAG"
            }
        }
    }
}