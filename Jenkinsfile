pipeline {
    agent any

environment {
    REPOSITORY = "https://github.com/mustafaerkc/python-web-app.git"
    EKS_CLUSTER_NAME = "test"
    ARGOCD_NAMESPACE = "argocd"
    ARGOCD_SERVER = "argocd.argocd.svc.local.cluster"
    NEXUS_URL ="https://repository.evam.dev"
    NEXUS_REPOSITORY_NAME = 'evam-charts'
    CHART_NAME = 'evam/python-app'
    VERSION = "1.0.${env.BUILD_ID}
    
}
    stages {
        stage("Build Docker Image & Push to Docker Hub") {
            steps {
                container("kaniko") {
                    script {
                        def context = "."
                        def dockerfile = "Dockerfile"
                        def image = "mustafaerkoc/python-app:1.0"
                        sh "/kaniko/executor --context ${context} --dockerfile ${dockerfile} --destination ${image}"
                    }
                }
            }
        }
        stage('Deploy with Helm') {
            steps {
                container('helm') {
                    sh 'helm version'
                }
            }
        }
        stage('Scan') {
      steps {
	  
        sh "curl -sOL https://github.com/aquasecurity/trivy/releases/download/v0.24.2/trivy_0.24.2_Linux-64bit.tar.gz"
        sh "tar -xvf trivy_0.24.2_Linux-64bit.tar.gz"
        sh './trivy image --no-progress  --severity CRITICAL mustafaerkoc/python-app:1.0'
      }
    }
    }

    post {
        always {
            echo "The process is completed."
        }
    }
}

