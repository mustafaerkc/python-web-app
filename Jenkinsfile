pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                script {
                    // GitHub reposundan kodu çek
                    git credentialsId: 'tokeeen', url: 'https://github.com/mustafaerkc/python-web-app.git'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Docker imajını oluştur
                    docker.build('mustafaerkoc/python-app:1.0', '.')
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    // Docker imajını DockerHub'a gönder
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-creds') {
                        docker.image('mustafaerkoc/python-app').push('latest')
                        docker.image('mustafaerkoc/python-app').push("${env.BUILD_NUMBER}")
                    }
                }
            }
        }
    }
}

