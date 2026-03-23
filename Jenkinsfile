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
                withCredentials([usernamePassword(credentialsId: "$DOCKERHUB_CREDS", usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                }
            }
        }

        stage('Build Image') {
            steps {
                script {
                    sh "docker build -t $DEV_IMAGE:latest ."
                }
            }
        }

        stage('Push Image') {
            steps {
                script {
                    sh "docker push $DEV_IMAGE:latest"
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh "./deploy.sh $DEV_IMAGE:latest"
                }
            }
        }
    }

    post {
        always {
            sh "docker rmi -f $DEV_IMAGE:latest || true"
            sh "docker rmi -f $PROD_IMAGE:latest || true"
        }
    }
}