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
        echo "deploy stage"
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
