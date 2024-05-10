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
    }
}

