pipeline {
    agent any

    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
        timestamps()
    }

    parameters {
        choice(
            name: 'ENV',
            choices: ['dev', 'stage', 'prod'],
            description: 'Select deployment environment'
        )
    }

    environment {
        AWS_REGION = "ap-south-1"
        AWS_ACCOUNT_ID = "447655430298"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main'
                    credentialsId: 'git-creds',
                    url: 'https://github.com/Nikhils2015/seto-project.git'
            }
        }

        stage('Set Environment Variables') {
            steps {
                script {
                    ECR_REPO = "seto-app-${params.ENV}"
                    FULL_IMAGE = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}:${IMAGE_TAG}"
                    echo "Environment: ${params.ENV}"
                    echo "ECR Repo: ${ECR_REPO}"
                    echo "Full Image: ${FULL_IMAGE}"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${ECR_REPO}:${IMAGE_TAG}", "app/")
                }
            }
        }

        stage('Login to ECR') {
            steps {
                sh """
                aws ecr get-login-password --region ${AWS_REGION} | \
                docker login --username AWS --password-stdin \
                447655430298.dkr.ecr.${AWS_REGION}.amazonaws.com
                """
            }
        }

        stage('Push Image to ECR') {
            steps {
                sh """
                docker tag ${ECR_REPO}:${IMAGE_TAG} ${FULL_IMAGE}
                docker push ${FULL_IMAGE}
                """
            }
        }

        stage('Deploy to Dev/Stage') {
            when {
                expression { params.ENV != 'prod' }
            }
            steps {
                sh """
                kubectl set image deployment/${params.ENV}-demo-app \
                demo-app=${FULL_IMAGE} \
                -n ${params.ENV}
                """
            }
        }

        stage('Approve Production Deployment') {
            when {
                expression { params.ENV == 'prod' }
            }
            steps {
                input message: "Approve Production Deployment?"
            }
        }

        stage('Deploy to Production') {
            when {
                expression { params.ENV == 'prod' }
            }
            steps {
                sh """
                kubectl set image deployment/prod-demo-app \
                demo-app=${FULL_IMAGE} \
                -n prod
                """
            }
        }
    }

    post {
        always {
            sh "docker system prune -af"
        }
        success {
            echo "Deployment Successful "
        }
        failure {
            echo "Pipeline Failed "
        }
    }
}

