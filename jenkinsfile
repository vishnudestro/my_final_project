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
                    // Condition: Change TARGET_REPO based on the branch name
                    if (env.BRANCH_NAME == 'main') {
                        env.TARGET_REPO = 'prod'  // Change to production repo if branch is main
                    }else {
                        env.TARGET_REPO = 'dev'  // Default to dev repo for other branches
                    }
                    echo "Using repository: ${env.TARGET_REPO}"
                    // Push the Docker image to Docker Hub
                    sh 'docker push ${DOCKER_IMAGE}/env.TARGET_REPO'
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
