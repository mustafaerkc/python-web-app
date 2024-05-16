pipeline {
    agent any

    environment {
        APP_NAME = "python-app"
        REPOSITORY = "https://github.com/mustafaerkc/python-web-app.git"
        EKS_CLUSTER_NAME = "test"
        ARGOCD_NAMESPACE = "argocd"
        ARGOCD_SERVER = "argocd.argocd.svc.local.cluster"
        NEXUS_ARTIFACT_ID = "python-app"
        NEXUS_URL = "https://repository.evam.dev"
        NEXUS_REPOSITORY_NAME = "evam-charts"
        CHART_NAME = "evam/python-app"
        VERSION = "1.0.${env.BUILD_ID}"
        FULL_CHART_NAME = "${APP_NAME}-${VERSION}.tgz"
    }

    stages {

    }
stage('SonarQube Code Analysis') {
            steps {
                dir("${WORKSPACE}"){
                // Run SonarQube analysis for Python
                script {
                    def scannerHome = tool name: 'scanner-name', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
                    withSonarQubeEnv('sonar') {
                        sh "echo $pwd"
                        sh "${scannerHome}/bin/sonar-scanner"
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

