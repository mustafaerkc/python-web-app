pipeline {
    agent any

    stages {
        stage("Build Docker Image & Push to Docker Hub") {
            steps {
                container("kaniko") {
                    script {
                        def context = "."
                        def dockerfile = "Dockerfile"
                        def image = "mustafaerkoc/python-app:latest"

                        sh "/kaniko/executor --context ${context} --dockerfile ${dockerfile} --destination ${image}"
                    }
                }
            }
        }
    }

    post {
        always {
            echo "The process is completed."
        }
    }
}

