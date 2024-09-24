pipeline {
  agent {
    label 'vm2'
  }

  stages {
    stage('Clone') {
      steps {
        git branch: 'main', url: 'https://github.com/rratchapol/jenkins-assignment.git'
        sh 'whoami'
      }
    }
    stage('Install Packet') {
      steps {
        sh 'npm install'
      }
    }
    stage('Run Unittest') {
      steps {
        sh 'npm test'
      }
    }
    stage('Run Robot') {
      steps {
        echo 'Create Container'
        sh 'docker compose -f ./docker-compose.dev.yaml up -d --build'
        
        echo 'Cloning Robots'
        dir('./robot/') {
          git branch: 'main', url: 'https://github.com/rratchapol/Robot-Test.git'
        }
        
        echo 'Running Robot Test'
        sh 'cd ./robot && python3 -m robot ./test-api.robot'
      }
    }
    stage('Build Docker Image') {
      steps {
        sh 'docker build -t tao/jenkins-assignment:latest .'
      }
    }
    stage('Push Image to Registry') {
      steps {
        sh 'docker push tao/jenkins-assignment:latest'
      }
    }
    stage('Clean Workspace') {
      steps {
        echo 'Stopping and Cleaning Containers'
        sh 'docker compose -f ./docker-compose.dev.yaml down'
        sh 'docker system prune -a -f'
      }
    }
    stage('Deploy to Preprod') {
      agent {
        label 'vm3'
      }
      steps {
        echo 'Pulling and Deploying on Preprod'
        sh 'docker pull tao/jenkins-assignment:latest'
        sh 'docker compose down'
        sh 'docker system prune -a -f'
        sh 'docker compose up -d --build'
      }
    }
  }
}
