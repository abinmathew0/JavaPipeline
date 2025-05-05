pipeline {
    agent any

    environment {
        SONARQUBE_SERVER = 'SonarQube'  // Jenkins global tool config name
    }

    tools {
        maven 'Maven_3.9'   // Jenkins global tool name
        jdk 'JDK_21'       // Jenkins global JDK name
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/abinmathew0/JavaPipeline.git'  // Replace with your repo
            }
        }

        stage('Build & Unit Test') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv("${SONARQUBE_SERVER}") {
                    sh 'mvn sonar:sonar'
                }
            }
        }

        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }
    }

    post {
        success {
            echo '✅ Build and analysis successful!'
        }
        failure {
            echo '❌ Build failed. Check logs!'
        }
    }
}
