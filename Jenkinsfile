pipeline {
    agent any

    environment {
        DOCKERHUB_CREDS = '2a719a61-c076-4d60-9042-d232ed6ffa1d'  // ID of your Jenkins Docker credentials
        DEV_IMAGE = "kumaresankarana/reactproj1-dev"
        PROD_IMAGE = "kumaresankarana/reactproj1-prod"
    }

    
    stages {

        // -----------------------------
        stage('Docker Login') {
            steps {
                echo "Logging in to Docker Hub..."
                withCredentials([usernamePassword(credentialsId: "$DOCKER_CRED_ID", usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                }
            }
        }

        // -----------------------------
        stage('Build & Push Dev Image') {
            when { branch 'dev' }
            steps {
                echo "Building Dev Docker Image..."
                sh "docker build -t $DEV_IMAGE:latest ."
                
                echo "Pushing Dev Docker Image to Docker Hub..."
                sh "docker push $DEV_IMAGE:latest"

                echo "Testing Dev Docker Image locally..."
                // Stop existing container if any
                sh "docker rm -f react-app || true"
                // Run dev container on port 8085
                sh "docker run -d --name react-app -p 8085:80 $DEV_IMAGE:latest"
                echo "Dev container should be accessible at http://<server-ip>:8085"
            }
        }

        // -----------------------------
        stage('Build & Push Prod Image') {
            when { branch 'master' }
            steps {
                echo "Building Prod Docker Image..."
                sh "docker build -t $PROD_IMAGE:latest ."
                
                echo "Pushing Prod Docker Image to Docker Hub..."
                sh "docker push $PROD_IMAGE:latest"
            }
        }

        // -----------------------------
        stage('Deploy') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'dev') {
                        echo "Deploying Dev Container..."
                        sh "./deploy.sh $DEV_IMAGE:latest"
                    } else if (env.BRANCH_NAME == 'master') {
                        echo "Deploying Prod Container..."
                        sh "./deploy.sh $PROD_IMAGE:latest"
                    }
                }
            }
        }
    }

    // -----------------------------
    post {
        always {
            echo "Cleaning up local Docker images..."
            sh "docker rm -f react-app || true"
            sh "docker rmi -f $DEV_IMAGE:latest || true"
            sh "docker rmi -f $PROD_IMAGE:latest || true"
        }
    }
}