pipeline {
    agent any

    stages {
        stage("Build Docker Image & Push to Docker Hub") {
            steps {
                container("kaniko") {
                    script {
                        def context = "."
                        def dockerfile = "Dockerfile"
                        def image = "mustafaerkoc/python-app:1.0"
                        sh "/kaniko/executor --context ${context} --dockerfile ${dockerfile} --destination ${image} "
                    }
                }
            }
        }
        stage('Deploy with Helm') {
            steps {
                container('helm') {
                    sh 'helm version'
                    // Helm komutlarını burada çalıştırabilirsiniz
                }
    }

    post {
        always {
            echo "The process is completed."
        }
    }
}
