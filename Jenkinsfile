pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                script {
                    // GitHub reposundan kodu çek
                    git credentialsId: 'github-token', url: 'https://github.com/mustafaerkc/python-web-app.git'
                }
            }
        }
    stage('Kaniko Build & Push Image') {
      steps {
        container('kaniko') {
          script {
            sh '''
            /kaniko/executor --dockerfile `pwd`/Dockerfile \
                             --context `pwd` \
                             --destination=hasanalperen/myweb:${BUILD_NUMBER}
            '''
          }
        }
      }
    }

    }
}

