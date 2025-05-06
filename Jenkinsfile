pipeline {
    agent any

    environment {
        SONARQUBE_SERVER = 'SonarQube'
        DOCKER_IMAGE = 'abinmathew0/enterprise-java-cicd'
    }

    tools {
        maven 'Maven_3.9'
        jdk 'JDK_21'
    }

    stages {
        stage('Build & Unit Tests') {
            steps {
                bat 'mvn clean install'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv("${SONARQUBE_SERVER}") {
                    bat 'mvn sonar:sonar'
                }
            }
        }

        stage('Archive Build Artifacts') {
            steps {
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }

        stage('Docker Build & Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    script {
                        bat "docker login -u %DOCKER_USER% -p %DOCKER_PASS%"
                        bat "docker build -t %DOCKER_IMAGE% ."
                        bat "docker push %DOCKER_IMAGE%"
                    }
                }
            }
        }
    }

    post {
        success {
            echo '✅ All stages completed successfully!'
        }
        failure {
            echo '❌ Build failed. Check logs!'
        }
    }
}
