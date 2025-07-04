pipeline {
    agent any

    environment {
        REPO = 'subadevanc/kimai'
        IMAGE_TAG = "${env.BUILD_NUMBER}"
        SSH_KEY = credentials('ec2-key')           // Your PEM file
        DOCKER_PASSWORD = credentials('docker-pass') // Optional if using docker-creds
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/subadevanc/Kimai-TechForce.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $REPO:$IMAGE_TAG ./docker'
            }
        }

        stage('Test (Simulated)') {
            steps {
                sh 'echo "Running tests..."'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh '''
                        echo $PASSWORD | docker login -u $USERNAME --password-stdin
                        docker push $REPO:$IMAGE_TAG
                    '''
                }
            }
        }

        stage('Deploy to EC2 (via Bastion)') {
            steps {
                sh '''
                    echo "Deploying image to application server..."

                    ssh -o StrictHostKeyChecking=no -i $SSH_KEY ec2-user@16.171.35.122 << EOF
                    ssh -o StrictHostKeyChecking=no ec2-user@172.31.34.207 '
                        docker login -u $USERNAME -p $PASSWORD &&
                        docker pull $REPO:$IMAGE_TAG &&
                        docker stop kimai || true &&
                        docker rm kimai || true &&
                        docker run -d --name kimai -p 8001:80 $REPO:$IMAGE_TAG
                    '
                    EOF
                '''
            }
        }
    }
}
