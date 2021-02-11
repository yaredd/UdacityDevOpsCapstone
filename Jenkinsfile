pipeline {
  agent any

  environment {
    imageName = 'yaredd/nginx-test-app'
    dockerImage = ''
  }

  stages {
    stage("lint") {
      agent {
        docker { image 'hadolint/hadolint:latest-debian' }
      }
      steps {
        sh "hadolint Dockerfile"
      }
    }
    stage("build") {
      steps {
        echo "build docker image"
        script {
          dockerImage = docker.build(imageName)
        }
      }
    }
    stage("push image") {
      steps {
        echo "push image to hub.docker.com using the dhockerhub credential and tag image with latetest and build number to track changes."
        script {
          docker.withRegistry('', 'dockerhub') {
            dockerImage.push("$BUILD_NUMBER")
            dockerImage.push("latest")
          }
        }
      }
    }
    stage("deploy") {

      steps {
        sh "/var/jenkins_home/kubectl apply -f website.yml"
      }
    }
    stage("test deployment") {
      steps {
        sh "/var/jenkins_home/kubectl get pods -o wide"
        sh "sleep 5000; curl http://172.16.3.7/"
      }
    }
  }
  post {
    success {
      echo "remove local docker images to cleanup"
      sh "docker rmi $imageName:latest"
      sh "docker rmi $imageName:$BUILD_NUMBER"
    }
  }
}
