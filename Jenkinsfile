pipeline {
    agent any

    environment {
        APP_NAME = "python-app"
        REPOSITORY = "https://github.com/mustafaerkc/python-web-app.git"
        EKS_CLUSTER_NAME = "test"
        ARGOCD_NAMESPACE = "argocd"
        ARGOCD_SERVER = "argocd.argocd.svc.local.cluster"
        NEXUS_ARTIFACT_ID= "python-app"
        NEXUS_URL = "https://repository.evam.dev"
        NEXUS_REPOSITORY_NAME = 'evam-charts'
        CHART_NAME = 'evam/python-app'
        VERSION = "1.0.${env.BUILD_ID}"
	FULL_CHART_NAME = "${env.python-app}-${env.VERSION}.tgz"
    }

    stages {
        stage("Build Docker Image & Push to Docker Hub") {
            steps {
                container("kaniko") {
                    script {
                        def context = "."
                        def dockerfile = "Dockerfile"
                        def image = "mustafaerkoc/python-app:1.0"
                    }
                }
            }
        }

        stage('Modify Chart Version') {
            steps {
                script {
			sh """#!/bin/bash
   # Print current version
   cat python-app/Chart.yaml | grep version
   
   # Update version using sed
   sed -i 's|version: .*|version: "${VERSION}"|' python-app/Chart.yaml
   
   # Print updated version
   cat python-app/Chart.yaml | grep version
   """
                }
            }
        }

        stage('Package with Helm') {
            steps {
                container('helm') {
                        sh "helm package python-app/."
                    
                }
            }
        }
        stage('Helm Push') {
            steps {
                container('helm') {
			sh "curl --data-binary "@${FULL_CHART_NAME}" http://helm-repo-chartmuseum.default.svc.cluster.local:8080/api/charts"
                    
                }
            }
        }

        stage('Scan') {
            steps {
                sh "curl -sOL https://github.com/aquasecurity/trivy/releases/download/v0.24.2/trivy_0.24.2_Linux-64bit.tar.gz"
                sh "tar -xvf trivy_0.24.2_Linux-64bit.tar.gz"
                sh './trivy image --no-progress --severity CRITICAL mustafaerkoc/python-app:1.0'
            }
        }
    }

    post {
        always {
            echo "The process is completed."
        }
    }
}

