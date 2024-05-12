pipeline {
    agent {
        kubernetes {
            yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    jenkins/agent-type: kaniko
spec:
  containers:
    - name: jnlp
      image: jenkins/inbound-agent:latest
      resources:
        requests:
          memory: "512Mi"
          cpu: "500m"
        limits:
          memory: "1024Mi"
          cpu: "1000m"
    - name: kaniko
      image: gcr.io/kaniko-project/executor:debug
      command:
        - /busybox/cat
      tty: true
      volumeMounts:
        - name: docker-config
          mountPath: /kaniko/.docker/
  volumes:
    - name: docker-config
      secret:
        secretName: docker-config
            """
        }
    }

    environment {
        DOCKERHUB_USERNAME = "zerohertzkr"
        IMAGE_NAME = "test"
    }

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

