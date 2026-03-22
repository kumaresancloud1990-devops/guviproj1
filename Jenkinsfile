pipeline {
    agent any

    environment {
        DEV_REPO = "kumaresankarana/reactproj1-dev"
        PROD_REPO = "kumaresankarana/reactproj1-prod"
    }

    stages {

        stage('Clone Code') {
            steps {
                git branch: "${env.BRANCH_NAME}", url: 'https://github.com/kumaresancloud1990-devops/guviproj1.git'
            }
        }

        stage('Build Image') {
            steps {
                sh 'docker build -t react-app .'
            }
        }

        stage('Push to Dev Repo') {
            when {
                branch 'dev'
            }
            steps {
                sh '''
                docker tag react-app $DEV_REPO:latest
                docker push $DEV_REPO:latest
                '''
            }
        }

        stage('Push to Prod Repo') {
            when {
                branch 'master'
            }
            steps {
                sh '''
                docker tag react-app $PROD_REPO:latest
                docker push $PROD_REPO:latest
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh './deploy.sh'
            }
        }
    }
}
