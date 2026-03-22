pipeline {
    agent any

    environment {
        DOCKERHUB_CREDS = '2a719a61-c076-4d60-9042-d232ed6ffa1d'  // ID of your Jenkins Docker credentials
        DEV_IMAGE = "kumaresankarana/reactproj1-dev"
        PROD_IMAGE = "kumaresankarana/reactproj1-prod"
    }

stages {

    stage('Docker Login') {
        steps {
            echo "Logging in to Docker Hub..."
            withCredentials([usernamePassword(credentialsId: DOCKERHUB_CREDS, usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                sh 'echo $PASS | docker login -u $USER --password-stdin'
            }
        }
    }

    stage('Build & Push Dev Image') {
        when {
            expression { env.BRANCH_NAME == 'dev' }  // ← Fixed
        }
        steps {
            script {
                sh "docker build -t $DEV_IMAGE:latest ."
                sh "docker push $DEV_IMAGE:latest"
            }
        }
    }

    stage('Build & Push Prod Image') {
        when {
            expression { env.BRANCH_NAME == 'main' }  // ← Fixed (or 'master' if your repo uses that)
        }
        steps {
            script {
                sh "docker build -t $PROD_IMAGE:latest ."
                sh "docker push $PROD_IMAGE:latest"
            }
        }
    }

    stage('Deploy') {
        when {
            expression { env.BRANCH_NAME == 'main' }  // ← Fixed
        }
        steps {
            script {
                sh "./deploy.sh $PROD_IMAGE:latest"
            }
        }
    }
}

post {
    always {
        echo "Cleaning up local Docker images..."
        sh "docker rmi -f $DEV_IMAGE:latest || true"
        sh "docker rmi -f $PROD_IMAGE:latest || true"
    }
}