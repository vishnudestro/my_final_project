pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'vishnu2naick'
        DOCKER_CREDENTIALS_ID = 'dockerhub'  //Jenkins Docker Hub credentials
    }

    stages {
        // stage('Clone Repository') {
        //     steps {
        //         // Cloning the Git repository
        //         git url: 'https://github.com/vishnudestro/my_final_project.git', branch: 'dev'
        //     }
        // }
        stage('Checking git repo'){
            steps{
                script{
                    echo "Target repository: ${env.TARGET_REPO}"

                    if (env.BRANCH_NAME == 'main') {
                        echo "main repository"
                        env.TARGET_REPO = 'prod'
                    }
                    else {
                        echo "dev repository"
                        env.TARGET_REPO = 'dev'
                    }
                }
            }

        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    // Login to Docker Hub using Jenkins credentials
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image to Docker Hub
                    sh 'docker push ${DOCKER_IMAGE}/${env.TARGET_REPO}'
                }
            }
        }
    }

    post {
        success {
            echo "Docker image pushed successfully!"
        }
        failure {
            echo "Something went wrong. Please check the logs."
        }
    }
}
